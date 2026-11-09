using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading;
using Microsoft.Win32.SafeHandles;

// YounuoAttach.exe — standalone, no Python needed.
//
// Does one thing: finds the RenoDX devkit pipe of the running game, and sends
//   initialize  ->  tools/call devkit_load_live_shaders {"deviceIndex":0}
// which is what makes the toon shader replacement active for this session.
//
// Why three open strategies: a previous client used FILE_FLAG_OVERLAPPED and got
// ERROR_ACCESS_DENIED against this devkit, while Python's plain CreateFileW worked.
// So try the simple one first and fall back, logging which one succeeded.
//
// usage:
//   YounuoAttach.exe              attach once, print the result, exit
//   YounuoAttach.exe --watch      keep watching, re-attach if the takeover drops
//   YounuoAttach.exe --wait 300   seconds to wait for the pipe (default 600)

internal static class Program
{
    private const uint Magic = 0x49584452;
    private const ushort ProtocolVersion = 1;
    private const byte KindRequest = 0;
    private const byte KindResponse = 1;
    private const byte KindEvent = 2;
    private const string TransportName = "mcp";
    private const int MaxPayload = 2 * 1024 * 1024;
    private const string PipePrefix = "renodx-devkit-mcp";

    private static StreamWriter _log;

    private static int Main(string[] args)
    {
        try { Console.OutputEncoding = Encoding.UTF8; } catch { }
        Console.Title = "Younuo Attach";
        Log("Younuo attach — toon shader takeover");

        int wait = 600;
        for (int i = 0; i < args.Length - 1; i++)
            if (args[i] == "--wait") int.TryParse(args[i + 1], out wait);
        bool watch = args.Contains("--watch");

        string pipe = WaitForPipe(wait);
        if (pipe == null)
        {
            Log("no " + PipePrefix + "* pipe found — start the game first (the devkit addon creates it).");
            Pause();
            return 3;
        }
        Log("pipe: " + pipe);

        string result;
        if (!Attach(pipe, out result))
        {
            Log("attach failed: " + result);
            Pause();
            return 4;
        }

        bool activated = result.IndexOf("\"activated\": true", StringComparison.Ordinal) >= 0
                         || result.IndexOf("\"activated\":true", StringComparison.Ordinal) >= 0
                         || result.IndexOf("activated", StringComparison.OrdinalIgnoreCase) >= 0;
        Log(activated ? "attached: toon takeover is live" : "attach returned without 'activated': " + Shorten(result));

        if (!watch)
        {
            if (!activated) Pause();
            return activated ? 0 : 5;
        }

        Log("watching (close this window to stop)");
        while (true)
        {
            Thread.Sleep(5000);
            string status;
            if (!TryCall(pipe, "devkit_status", "{}", out status))
            {
                Log("pipe lost; waiting for the game/pipe to come back");
                pipe = WaitForPipe(3600);
                if (pipe == null) { Log("gave up"); return 0; }
            }
        }
    }

    private static string WaitForPipe(int seconds)
    {
        DateTime deadline = DateTime.UtcNow.AddSeconds(seconds);
        while (DateTime.UtcNow < deadline)
        {
            string name = FindGamePipe();
            if (name != null) return name;
            Thread.Sleep(400);
        }
        return null;
    }

    // Prefer the pipe whose trailing pid belongs to a live process (the game)
    private static string FindGamePipe()
    {
        List<string> candidates;
        try
        {
            candidates = Directory.GetFiles(@"\\.\pipe\")
                .Select(Path.GetFileName)
                .Where(n => n != null && n.StartsWith(PipePrefix, StringComparison.OrdinalIgnoreCase))
                .ToList();
        }
        catch { return null; }
        if (candidates.Count == 0) return null;

        foreach (string candidate in candidates)
        {
            string[] parts = candidate.Split('-');
            int pid;
            if (parts.Length > 0 && int.TryParse(parts[parts.Length - 1], out pid))
            {
                try { Process.GetProcessById(pid); return candidate; } catch { }
            }
        }
        candidates.Sort(StringComparer.OrdinalIgnoreCase);
        return candidates[0];
    }

    private static bool Attach(string pipe, out string result)
    {
        string reply = null;
        Client client = null;
        Exception last = null;
        // 在后台线程里做，主线程限时等待：管道读是阻塞的，不能让整个程序挂死
        var worker = new Thread(() =>
        {
            try
            {
                client = Client.Open(pipe);
                client.Handshake();
                reply = client.CallTool("devkit_load_live_shaders", "{\"deviceIndex\":0}");
            }
            catch (Exception e) { last = e; }
        });
        worker.IsBackground = true;
        worker.Start();
        if (!worker.Join(TimeSpan.FromSeconds(45)))
        {
            result = "timed out talking to the devkit (no reply in 45 s)";
            return false;
        }
        if (client == null || last != null)
        {
            result = last != null ? last.GetType().Name + ": " + last.Message : "no client";
            return false;
        }
        client.Close();
        result = reply;
        return true;
    }

    private static bool TryCall(string pipe, string tool, string argsJson, out string result)
    {
        result = null;
        try
        {
            var client = Client.Open(pipe);
            client.Handshake();
            result = client.CallTool(tool, argsJson);
            client.Close();
            return true;
        }
        catch { return false; }
    }

    private static string Shorten(string text)
    {
        if (string.IsNullOrEmpty(text)) return "(empty)";
        text = text.Replace("\r", " ").Replace("\n", " ");
        return text.Length <= 400 ? text : text.Substring(0, 400) + "...";
    }

    private static void Pause()
    {
        // 只在真正的交互式控制台里等待按键，避免被脚本调用时挂住
        if (Console.IsInputRedirected) return;
        Console.WriteLine();
        Console.WriteLine("press enter to close ...");
        try { Console.ReadLine(); } catch { }
    }

    private static void Log(string message)
    {
        string line = "[" + DateTime.Now.ToString("HH:mm:ss") + "] " + message;
        Console.WriteLine(line);
        try
        {
            if (_log == null)
                _log = new StreamWriter(Path.Combine(Here(), "YounuoAttach.log"), true, Encoding.UTF8) { AutoFlush = true };
            _log.WriteLine(line);
        }
        catch { }
    }

    private static string Here()
    {
        return Path.GetDirectoryName(Process.GetCurrentProcess().MainModule.FileName) ?? ".";
    }
}

internal sealed class Client : IDisposable
{
    private const byte KindRequest = 0;
    private const byte KindResponse = 1;
    private const byte KindEvent = 2;
    private const int MaxPayload = 2 * 1024 * 1024;
    private const string TransportName = "mcp";

    [DllImport("kernel32.dll", SetLastError = true, CharSet = CharSet.Unicode)]
    private static extern SafeFileHandle CreateFileW(string name, uint access, uint share, IntPtr sa,
                                                     uint disposition, uint flags, IntPtr template);
    private const uint GenericReadWrite = 0xC0000000;
    private const uint ShareReadWrite = 0x00000003;
    private const uint OpenExisting = 3;
    private const uint FileAttributeNormal = 0x00000080;

    private Stream _stream;
    private ulong _id;
    private bool _ready;

    public static Client Open(string pipeName)
    {
        string path = @"\\.\pipe\" + pipeName;
        Exception last = null;

        // 策略 1：Python 用的那种（FILE_ATTRIBUTE_NORMAL）
        foreach (uint flags in new uint[] { FileAttributeNormal, 0 })
        {
            SafeFileHandle handle = CreateFileW(path, GenericReadWrite, ShareReadWrite, IntPtr.Zero, OpenExisting, flags, IntPtr.Zero);
            if (!handle.IsInvalid)
                return new Client { _stream = new FileStream(handle, FileAccess.ReadWrite, 1, false) };
            last = new IOException("CreateFileW(flags=0x" + flags.ToString("X") + ") failed, error " + Marshal.GetLastWin32Error());
        }

        // 策略 2：.NET 自己打开
        try
        {
            return new Client { _stream = new FileStream(path, FileMode.Open, FileAccess.ReadWrite, FileShare.ReadWrite) };
        }
        catch (Exception e) { last = e; }

        throw last ?? new IOException("cannot open " + path);
    }

    public void Handshake()
    {
        if (_ready) return;
        Call("initialize", "{\"protocolVersion\":\"2025-11-25\",\"capabilities\":{\"tools\":{}}," +
                           "\"clientInfo\":{\"name\":\"younuo-attach\",\"version\":\"1.0\"}}");
        Send(KindRequest, ++_id, "{\"jsonrpc\":\"2.0\",\"method\":\"notifications/initialized\"}");
        _ready = true;
    }

    public string CallTool(string tool, string argumentsJson)
    {
        return Call("tools/call", "{\"name\":\"" + tool + "\",\"arguments\":" + argumentsJson + "}");
    }

    private string Call(string method, string paramsJson)
    {
        ulong requestId = ++_id;
        Send(KindRequest, requestId,
             "{\"jsonrpc\":\"2.0\",\"id\":" + requestId + ",\"method\":\"" + method + "\",\"params\":" + paramsJson + "}");
        while (true)
        {
            byte kind; ulong id; string body;
            Receive(out kind, out id, out body);
            if (kind == KindEvent) continue;
            if (kind != KindResponse || id != requestId) continue;
            if (body.Contains("\"error\"")) throw new InvalidOperationException(body);
            return body;
        }
    }

    private void Send(byte kind, ulong id, string payload)
    {
        byte[] body = Encoding.UTF8.GetBytes(payload);
        byte[] name = Encoding.UTF8.GetBytes(TransportName);
        byte[] frame = new byte[24 + name.Length + body.Length];
        Buffer.BlockCopy(BitConverter.GetBytes(0x49584452u), 0, frame, 0, 4);
        Buffer.BlockCopy(BitConverter.GetBytes((ushort)1), 0, frame, 4, 2);
        frame[6] = kind;
        frame[7] = 0;
        Buffer.BlockCopy(BitConverter.GetBytes(id), 0, frame, 8, 8);
        Buffer.BlockCopy(BitConverter.GetBytes((uint)name.Length), 0, frame, 16, 4);
        Buffer.BlockCopy(BitConverter.GetBytes((uint)body.Length), 0, frame, 20, 4);
        Buffer.BlockCopy(name, 0, frame, 24, name.Length);
        Buffer.BlockCopy(body, 0, frame, 24 + name.Length, body.Length);
        _stream.Write(frame, 0, frame.Length);
        _stream.Flush();
    }

    private void Receive(out byte kind, out ulong id, out string body)
    {
        byte[] header = ReadExact(24);
        kind = header[6];
        id = BitConverter.ToUInt64(header, 8);
        uint nameSize = BitConverter.ToUInt32(header, 16);
        uint payloadSize = BitConverter.ToUInt32(header, 20);
        if (payloadSize > MaxPayload) throw new IOException("reply too large: " + payloadSize);
        if (nameSize > 0) ReadExact((int)nameSize);
        body = payloadSize > 0 ? Encoding.UTF8.GetString(ReadExact((int)payloadSize)) : "";
    }

    private byte[] ReadExact(int count)
    {
        byte[] buffer = new byte[count];
        int got = 0;
        while (got < count)
        {
            int n = _stream.Read(buffer, got, count - got);
            if (n <= 0) throw new IOException("pipe closed");
            got += n;
        }
        return buffer;
    }

    public void Close()
    {
        try { if (_stream != null) _stream.Dispose(); } catch { }
    }

    public void Dispose() { Close(); }
}
