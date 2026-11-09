using System;
using System.Diagnostics;
using System.IO;

internal static class YounuoLauncher
{
    private static int Main()
    {
#if UNINSTALL
        const string mode = "Uninstall";
#else
        const string mode = "Install";
#endif
        int code = 1;
        try
        {
            string script = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "Setup", "Deploy.ps1");
            string shell = Path.Combine(Environment.SystemDirectory, "WindowsPowerShell", "v1.0", "powershell.exe");
            using (Process process = Process.Start(new ProcessStartInfo(shell,
                "-NoProfile -ExecutionPolicy Bypass -File \"" + script + "\" -Mode " + mode)
                { UseShellExecute = false }))
            {
                process.WaitForExit();
                code = process.ExitCode;
            }
        }
        catch (Exception error)
        {
            Console.WriteLine(error.Message);
        }
        if (!Console.IsInputRedirected)
        {
            Console.WriteLine("Press any key to close.");
            Console.ReadKey(true);
        }
        return code;
    }
}
