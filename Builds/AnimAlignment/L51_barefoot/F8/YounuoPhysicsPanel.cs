using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Drawing;
using System.Globalization;
using System.IO;
using System.Runtime.InteropServices;
using System.Text;
using System.Threading;
using System.Windows.Forms;

internal static class Program
{
    [STAThread]
    private static int Main(string[] args)
    {
        if (args.Length == 1 && args[0] == "--self-test")
            return SelfTest.Run();

        bool first;
        using (var mutex = new Mutex(true, @"Local\YounuoPhysicsPanel", out first))
        using (var show = new EventWaitHandle(false, EventResetMode.AutoReset, @"Local\YounuoPhysicsPanel_Show"))
        {
            if (!first)
            {
                show.Set();
                return 0;
            }

            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            var baseDirectory = AppDomain.CurrentDomain.BaseDirectory;
            using (var form = new TuningPanel(new PanelSettings(
                Path.Combine(baseDirectory, "settings.txt"))))
            {
                form.Shown += delegate
                {
                    var waiter = ThreadPool.RegisterWaitForSingleObject(show, delegate
                    {
                        try { form.BeginInvoke(new Action(form.BringPanelForward)); }
                        catch (ObjectDisposedException) { }
                        catch (InvalidOperationException) { }
                    }, null, Timeout.Infinite, false);
                    form.FormClosed += delegate { waiter.Unregister(null); };
                };
                Application.Run(form);
            }
        }
        return 0;
    }
}

internal sealed class PanelSettingsData
{
    internal int Hair;
    internal int Chest;
    internal int Skirt;
    internal bool SkirtPhysics;
    internal bool SkirtSelfCollision;
    internal string SkirtCollisionScope;
    internal string SkirtPrecision;
    internal bool ShoesVisible;
    internal bool BarefootPose;
    internal double BarefootHeightCm;
    internal bool BackWeaponsVisible;
}

internal sealed class PanelSettings
{
    private const int MoveFileReplaceExisting = 0x1;
    private const int MoveFileWriteThrough = 0x8;

    [DllImport("kernel32.dll", SetLastError = true, CharSet = CharSet.Unicode)]
    private static extern bool MoveFileEx(string existingFileName,
        string newFileName, int flags);

    internal const string ScopeAdjacent = "adjacent";
    internal const string ScopeAll = "all";
    internal const string PrecisionLow = "low";
    internal const string PrecisionNormal = "normal";
    internal const string PrecisionHigh = "high";

    private readonly string path;
    private readonly string defaultsPath;

    internal PanelSettings(string path)
    {
        this.path = path;
        var directory = Path.GetDirectoryName(path);
        if (string.IsNullOrEmpty(directory))
            directory = ".";
        defaultsPath = Path.Combine(directory, "defaults.txt");
    }

    internal string SettingsPath
    {
        get { return path; }
    }

    internal string DefaultsPath
    {
        get { return defaultsPath; }
    }

    internal bool TryRead(out PanelSettingsData data, out bool needsMigration)
    {
        needsMigration = false;
        var defaultHeight = ReadFactoryHeight();
        if (!File.Exists(path))
        {
            data = CreateDefaults(defaultHeight);
            return true;
        }

        string text;
        try
        {
            text = File.ReadAllText(path, Encoding.UTF8);
        }
        catch (IOException)
        {
            data = null;
            return false;
        }
        catch (UnauthorizedAccessException)
        {
            data = null;
            return false;
        }

        return TryParse(text, defaultHeight, out data, out needsMigration);
    }

    internal static bool TryParse(string text, double defaultHeight,
        out PanelSettingsData data, out bool isLegacy)
    {
        data = null;
        isLegacy = false;
        if (text == null)
            return false;

        var items = new List<string>();
        var lines = text.Replace("\r\n", "\n").Replace('\r', '\n').Split('\n');
        for (var i = 0; i < lines.Length; i++)
        {
            var line = lines[i].Trim();
            if (line.Length > 0)
                items.Add(line);
        }
        if (items.Count == 0)
            return false;

        var hasEquals = false;
        for (var i = 0; i < items.Count; i++)
        {
            if (items[i].IndexOf('=') >= 0)
            {
                hasEquals = true;
                break;
            }
        }

        if (!hasEquals)
        {
            var parts = string.Join(" ", items.ToArray()).Split(
                (char[])null, StringSplitOptions.RemoveEmptyEntries);
            if (parts.Length != 3)
                return false;

            var numbers = new int[3];
            for (var i = 0; i < parts.Length; i++)
            {
                if (!TryRangeValue(parts[i], out numbers[i]))
                    return false;
            }

            var legacy = CreateDefaults(defaultHeight);
            legacy.Hair = numbers[0];
            legacy.Chest = numbers[1];
            legacy.Skirt = numbers[2];
            data = legacy;
            isLegacy = true;
            return true;
        }

        var parsed = CreateDefaults(defaultHeight);
        var seen = new HashSet<string>(StringComparer.Ordinal);
        for (var i = 0; i < items.Count; i++)
        {
            var item = items[i];
            var equals = item.IndexOf('=');
            if (equals <= 0)
                return false;

            var key = item.Substring(0, equals).Trim();
            var value = item.Substring(equals + 1).Trim();
            if (key.Length == 0)
                return false;

            if (!seen.Add(key))
                return false;

            int number;
            bool flag;
            double height;
            switch (key)
            {
                case "version":
                    if (value != "2")
                        return false;
                    break;
                case "hair":
                    if (!TryRangeValue(value, out number))
                        return false;
                    parsed.Hair = number;
                    break;
                case "chest":
                    if (!TryRangeValue(value, out number))
                        return false;
                    parsed.Chest = number;
                    break;
                case "skirt":
                    if (!TryRangeValue(value, out number))
                        return false;
                    parsed.Skirt = number;
                    break;
                case "skirt_physics":
                    if (!TryBoolValue(value, out flag))
                        return false;
                    parsed.SkirtPhysics = flag;
                    break;
                case "skirt_self_collision":
                    if (!TryBoolValue(value, out flag))
                        return false;
                    parsed.SkirtSelfCollision = flag;
                    break;
                case "skirt_collision_scope":
                    if (value != ScopeAdjacent && value != ScopeAll)
                        return false;
                    parsed.SkirtCollisionScope = value;
                    break;
                case "skirt_precision":
                    if (value != PrecisionLow && value != PrecisionNormal && value != PrecisionHigh)
                        return false;
                    parsed.SkirtPrecision = value;
                    break;
                case "shoes_visible":
                    if (!TryBoolValue(value, out flag))
                        return false;
                    parsed.ShoesVisible = flag;
                    break;
                case "barefoot_pose":
                    if (!TryBoolValue(value, out flag))
                        return false;
                    parsed.BarefootPose = flag;
                    break;
                case "barefoot_height_cm":
                    if (!TryHeightValue(value, out height))
                        return false;
                    parsed.BarefootHeightCm = height;
                    break;
                case "back_weapons_visible":
                    if (!TryBoolValue(value, out flag))
                        return false;
                    parsed.BackWeaponsVisible = flag;
                    break;
                default:
                    // Unknown keys are deliberately ignored for forward compatibility.
                    break;
            }
        }

        data = parsed;
        return true;
    }

    internal PanelSettingsData CreateDefaults()
    {
        return CreateDefaults(ReadFactoryHeight());
    }

    internal static PanelSettingsData CreateDefaults(double factoryHeight)
    {
        var data = new PanelSettingsData();
        data.Hair = 50;
        data.Chest = 50;
        data.Skirt = 50;
        data.SkirtPhysics = true;
        data.SkirtSelfCollision = true;
        data.SkirtCollisionScope = ScopeAdjacent;
        data.SkirtPrecision = PrecisionNormal;
        data.ShoesVisible = true;
        data.BarefootPose = true;
        data.BarefootHeightCm = factoryHeight;
        data.BackWeaponsVisible = true;
        return data;
    }

    internal double ReadFactoryHeight()
    {
        try
        {
            if (!File.Exists(defaultsPath))
                return 0;

            var lines = File.ReadAllLines(defaultsPath, Encoding.UTF8);
            for (var i = 0; i < lines.Length; i++)
            {
                var line = lines[i].Trim();
                var equals = line.IndexOf('=');
                if (equals <= 0)
                    continue;
                if (line.Substring(0, equals).Trim() != "barefoot_height_cm")
                    continue;

                double height;
                return TryHeightValue(line.Substring(equals + 1).Trim(), out height)
                    ? height : 0;
            }
        }
        catch (IOException) { }
        catch (UnauthorizedAccessException) { }
        return 0;
    }

    internal void Write(PanelSettingsData data)
    {
        if (!IsWritable(data))
            throw new InvalidOperationException("设置值超出允许范围。");

        var text = new StringBuilder();
        text.Append("version=2\r\n");
        text.Append("hair=").Append(data.Hair.ToString(CultureInfo.InvariantCulture)).Append("\r\n");
        text.Append("chest=").Append(data.Chest.ToString(CultureInfo.InvariantCulture)).Append("\r\n");
        text.Append("skirt=").Append(data.Skirt.ToString(CultureInfo.InvariantCulture)).Append("\r\n");
        text.Append("skirt_physics=").Append(data.SkirtPhysics ? "1" : "0").Append("\r\n");
        text.Append("skirt_self_collision=").Append(data.SkirtSelfCollision ? "1" : "0").Append("\r\n");
        text.Append("skirt_collision_scope=").Append(data.SkirtCollisionScope).Append("\r\n");
        text.Append("skirt_precision=").Append(data.SkirtPrecision).Append("\r\n");
        text.Append("shoes_visible=").Append(data.ShoesVisible ? "1" : "0").Append("\r\n");
        text.Append("barefoot_pose=").Append(data.BarefootPose ? "1" : "0").Append("\r\n");
        text.Append("barefoot_height_cm=").Append(FormatHeight(data.BarefootHeightCm)).Append("\r\n");
        text.Append("back_weapons_visible=").Append(data.BackWeaponsVisible ? "1" : "0").Append("\r\n");

        WriteAtomic(text.ToString());
    }

    private void WriteAtomic(string text)
    {
        var directory = Path.GetDirectoryName(path);
        if (!string.IsNullOrEmpty(directory) && !Directory.Exists(directory))
            Directory.CreateDirectory(directory);

        var temporary = path + ".tmp";
        var encoding = new UTF8Encoding(false);
        try
        {
            using (var stream = new FileStream(temporary, FileMode.Create,
                FileAccess.Write, FileShare.None))
            using (var writer = new StreamWriter(stream, encoding))
            {
                writer.Write(text);
                writer.Flush();
                stream.Flush(true);
            }

            if (!MoveFileEx(Path.GetFullPath(temporary), Path.GetFullPath(path),
                MoveFileReplaceExisting | MoveFileWriteThrough))
            {
                throw new IOException("无法替换设置文件。",
                    new Win32Exception(Marshal.GetLastWin32Error()));
            }
        }
        finally
        {
            if (File.Exists(temporary))
            {
                try { File.Delete(temporary); }
                catch (IOException) { }
                catch (UnauthorizedAccessException) { }
            }
        }
    }

    private static bool IsWritable(PanelSettingsData data)
    {
        if (data == null)
            return false;
        if (data.Hair < 0 || data.Hair > 100 ||
            data.Chest < 0 || data.Chest > 100 ||
            data.Skirt < 0 || data.Skirt > 100)
            return false;
        if (double.IsNaN(data.BarefootHeightCm) ||
            double.IsInfinity(data.BarefootHeightCm) ||
            data.BarefootHeightCm < 0 || data.BarefootHeightCm > 20)
            return false;
        if (data.SkirtCollisionScope != ScopeAdjacent &&
            data.SkirtCollisionScope != ScopeAll)
            return false;
        if (data.SkirtPrecision != PrecisionLow &&
            data.SkirtPrecision != PrecisionNormal &&
            data.SkirtPrecision != PrecisionHigh)
            return false;
        return true;
    }

    private static bool TryRangeValue(string text, out int value)
    {
        return int.TryParse(text, NumberStyles.None, CultureInfo.InvariantCulture,
            out value) && value >= 0 && value <= 100;
    }

    private static bool TryBoolValue(string text, out bool value)
    {
        if (text == "0")
        {
            value = false;
            return true;
        }
        if (text == "1")
        {
            value = true;
            return true;
        }
        value = false;
        return false;
    }

    private static bool TryHeightValue(string text, out double value)
    {
        value = 0;
        if (string.IsNullOrEmpty(text))
            return false;

        var hasDigit = false;
        var hasPoint = false;
        for (var i = 0; i < text.Length; i++)
        {
            var c = text[i];
            if (c >= '0' && c <= '9')
            {
                hasDigit = true;
                continue;
            }
            if (c == '.' && !hasPoint)
            {
                hasPoint = true;
                continue;
            }
            return false;
        }
        if (!hasDigit)
            return false;
        if (!double.TryParse(text, NumberStyles.AllowDecimalPoint,
            CultureInfo.InvariantCulture, out value))
            return false;
        if (double.IsNaN(value) || double.IsInfinity(value) ||
            value < 0 || value > 20)
            return false;
        return true;
    }

    private static string FormatHeight(double value)
    {
        var rounded = Math.Round(value, 4, MidpointRounding.AwayFromZero);
        return rounded.ToString("0.####", CultureInfo.InvariantCulture);
    }
}

internal sealed class TuningPanel : Form
{
    private static readonly Color BackgroundColor = Color.FromArgb(24, 27, 31);
    private static readonly Color PanelColor = Color.FromArgb(30, 34, 39);
    private static readonly Color TextColor = Color.FromArgb(240, 240, 242);
    private static readonly Color MutedColor = Color.FromArgb(184, 192, 200);
    private static readonly Color DisabledColor = Color.FromArgb(112, 119, 127);
    private static readonly Color AccentColor = Color.FromArgb(232, 196, 122);

    private readonly PanelSettings settings;
    private readonly string statusPath;
    private readonly TrackBar[] sliders;
    private readonly Label[] readouts;
    private readonly CheckBox skirtPhysics;
    private readonly CheckBox skirtSelfCollision;
    private readonly ComboBox collisionScope;
    private readonly ComboBox precision;
    private readonly CheckBox shoesVisible;
    private readonly CheckBox barefootPose;
    private readonly NumericUpDown barefootHeight;
    private readonly CheckBox backWeaponsVisible;
    private Label scopeLabel;
    private Label precisionLabel;
    private Label heightLabel;
    private Label heightUnit;
    private Label heightHint;
    private readonly Label status;
    private readonly Label saveHint;
    private readonly System.Windows.Forms.Timer saveTimer;
    private readonly System.Windows.Forms.Timer statusTimer;
    private bool loading;

    internal TuningPanel(PanelSettings settings)
    {
        this.settings = settings;
        var directory = Path.GetDirectoryName(settings.SettingsPath);
        if (string.IsNullOrEmpty(directory))
            directory = ".";
        statusPath = Path.Combine(directory, "status.txt");

        PanelSettingsData data;
        bool needsMigration;
        var readOk = settings.TryRead(out data, out needsMigration);
        if (!readOk)
            data = settings.CreateDefaults();

        Text = "尤诺 · 角色与物理调节";
        Font = new Font("Microsoft YaHei UI", 10F);
        AutoScaleMode = AutoScaleMode.Dpi;
        ClientSize = new Size(600, 666);
        FormBorderStyle = FormBorderStyle.FixedDialog;
        MaximizeBox = false;
        MinimizeBox = false;
        StartPosition = FormStartPosition.CenterScreen;
        TopMost = true;
        BackColor = BackgroundColor;
        ForeColor = TextColor;

        loading = true;
        var title = AddLabel(this, "尤诺 · 角色与物理", 24, 14, 360);
        title.Font = new Font(Font.FontFamily, 15F, FontStyle.Bold);
        title.ForeColor = AccentColor;
        title.Height = 32;

        var subtitle = AddLabel(this, "F8 打开 · Esc 返回游戏", 24, 46, 360);
        subtitle.ForeColor = MutedColor;
        var autoSave = AddLabel(this, "更改会自动保存", 404, 46, 172);
        autoSave.ForeColor = MutedColor;
        autoSave.TextAlign = ContentAlignment.MiddleRight;

        var swingGroup = AddGroup("摆幅", 20, 76, 560, 170);
        var names = new[] { "头发及双马尾", "胸部", "裙摆" };
        var values = new[] { data.Hair, data.Chest, data.Skirt };
        sliders = new TrackBar[3];
        readouts = new Label[3];
        for (var i = 0; i < sliders.Length; i++)
        {
            var y = 28 + i * 44;
            AddLabel(swingGroup, names[i], 12, y + 7, 112);
            readouts[i] = AddLabel(swingGroup, values[i] + "%", 466, y + 7, 60);
            readouts[i].TextAlign = ContentAlignment.MiddleRight;
            readouts[i].Font = new Font(Font, FontStyle.Bold);

            var slider = new TrackBar
            {
                Minimum = 0,
                Maximum = 100,
                SmallChange = 1,
                LargeChange = 10,
                TickStyle = TickStyle.None,
                Value = values[i],
                Location = new Point(126, y),
                Size = new Size(326, 37),
                AccessibleName = names[i] + "摆幅"
            };
            swingGroup.Controls.Add(slider);
            sliders[i] = slider;
        }

        var skirtGroup = AddGroup("裙子", 20, 254, 560, 198);
        skirtPhysics = AddCheck(skirtGroup, "开启裙子物理", 14, 26, 300);
        skirtPhysics.Checked = data.SkirtPhysics;
        skirtSelfCollision = AddCheck(skirtGroup, "开启裙子自碰撞", 34, 62, 300);
        skirtSelfCollision.Checked = data.SkirtSelfCollision;

        scopeLabel = AddLabel(skirtGroup, "裙层碰撞范围", 34, 101, 130);
        collisionScope = AddCombo(skirtGroup, 174, 97, 200,
            new[] { "相邻裙层", "全部裙层" });
        collisionScope.SelectedIndex = data.SkirtCollisionScope == PanelSettings.ScopeAll ? 1 : 0;
        collisionScope.AccessibleName = "裙层碰撞范围";

        precisionLabel = AddLabel(skirtGroup, "碰撞精度", 34, 139, 130);
        precision = AddCombo(skirtGroup, 174, 135, 200,
            new[] { "低", "标准", "高" });
        precision.SelectedIndex = data.SkirtPrecision == PanelSettings.PrecisionLow ? 0 :
            data.SkirtPrecision == PanelSettings.PrecisionHigh ? 2 : 1;
        precision.AccessibleName = "碰撞精度";
        var precisionHint = AddLabel(skirtGroup, "精度作用于共用物理计算；全部裙层更耗性能", 34, 171, 500);
        precisionHint.Font = new Font(Font.FontFamily, 8F);
        precisionHint.ForeColor = MutedColor;

        var gearGroup = AddGroup("鞋子与武器", 20, 460, 560, 140);
        shoesVisible = AddCheck(gearGroup, "显示鞋子", 14, 24, 245);
        shoesVisible.Checked = data.ShoesVisible;
        barefootPose = AddCheck(gearGroup, "光脚姿态修正", 268, 24, 260);
        barefootPose.Checked = data.BarefootPose;

        heightLabel = AddLabel(gearGroup, "脱鞋高度补偿", 34, 63, 130);
        barefootHeight = new NumericUpDown
        {
            Minimum = 0m,
            Maximum = 20m,
            Increment = 0.1m,
            DecimalPlaces = DecimalPlacesFor(data.BarefootHeightCm),
            Location = new Point(174, 59),
            Size = new Size(90, 26),
            TextAlign = HorizontalAlignment.Right,
            BackColor = Color.FromArgb(245, 246, 248),
            ForeColor = BackgroundColor,
            ThousandsSeparator = false,
            AccessibleName = "脱鞋高度补偿"
        };
        decimal heightValue;
        try { heightValue = (decimal)data.BarefootHeightCm; }
        catch (OverflowException) { heightValue = 0m; }
        if (heightValue < barefootHeight.Minimum) heightValue = barefootHeight.Minimum;
        if (heightValue > barefootHeight.Maximum) heightValue = barefootHeight.Maximum;
        barefootHeight.Value = heightValue;
        gearGroup.Controls.Add(barefootHeight);

        heightUnit = AddLabel(gearGroup, "厘米", 272, 63, 44);
        heightHint = AddLabel(gearGroup, "姿态修正另自动补偿", 330, 63, 210);
        heightHint.Font = new Font(Font.FontFamily, 8.5F);
        heightHint.ForeColor = MutedColor;

        backWeaponsVisible = AddCheck(gearGroup, "显示背部武器及刀鞘", 14, 102, 340);
        backWeaponsVisible.Checked = data.BackWeaponsVisible;

        status = AddLabel(this, "等待游戏应用设置", 24, 610, 350);
        status.AutoEllipsis = true;
        status.ForeColor = MutedColor;
        saveHint = AddLabel(this, "更改会自动保存", 24, 636, 350);
        saveHint.Font = new Font(Font.FontFamily, 8.5F);
        saveHint.ForeColor = DisabledColor;

        var reset = new Button
        {
            Text = "恢复默认",
            Location = new Point(384, 606),
            Size = new Size(90, 32),
            FlatStyle = FlatStyle.Flat,
            BackColor = Color.FromArgb(58, 64, 72),
            ForeColor = TextColor,
            UseVisualStyleBackColor = false
        };
        reset.FlatAppearance.BorderColor = Color.FromArgb(84, 92, 102);
        reset.AccessibleName = "恢复默认设置";
        var close = new Button
        {
            Text = "关闭",
            Location = new Point(482, 606),
            Size = new Size(90, 32),
            FlatStyle = FlatStyle.Flat,
            BackColor = AccentColor,
            ForeColor = BackgroundColor,
            UseVisualStyleBackColor = false
        };
        close.FlatAppearance.BorderColor = AccentColor;
        close.AccessibleName = "关闭设置面板";
        Controls.Add(reset);
        Controls.Add(close);
        CancelButton = close;
        close.Click += delegate { Close(); };
        reset.Click += delegate { HandleReset(); };

        for (var i = 0; i < sliders.Length; i++)
            sliders[i].ValueChanged += HandleSliderChange;
        skirtPhysics.CheckedChanged += HandleOptionChange;
        skirtSelfCollision.CheckedChanged += HandleOptionChange;
        collisionScope.SelectedIndexChanged += HandleOptionChange;
        precision.SelectedIndexChanged += HandleOptionChange;
        shoesVisible.CheckedChanged += HandleOptionChange;
        barefootPose.CheckedChanged += HandleOptionChange;
        backWeaponsVisible.CheckedChanged += HandleOptionChange;
        barefootHeight.ValueChanged += HandleOptionChange;

        loading = false;
        UpdateEnabledStates();

        saveTimer = new System.Windows.Forms.Timer { Interval = 150 };
        saveTimer.Tick += delegate
        {
            saveTimer.Stop();
            SaveNow();
        };
        statusTimer = new System.Windows.Forms.Timer { Interval = 800 };
        statusTimer.Tick += delegate { RefreshStatus(); };
        statusTimer.Start();
        RefreshStatus();

        FormClosing += delegate
        {
            if (saveTimer.Enabled)
                SaveNow();
            saveTimer.Dispose();
            statusTimer.Dispose();
        };

        if (needsMigration)
            SaveNow();
        if (!readOk)
            SetSaveHint("原来的设置无法读取，已使用默认值", Color.FromArgb(230, 170, 90));
    }

    internal void BringPanelForward()
    {
        if (WindowState == FormWindowState.Minimized)
            WindowState = FormWindowState.Normal;
        Show();
        Activate();
        BringToFront();
    }

    private Label AddLabel(Control parent, string text, int x, int y, int width)
    {
        var label = new Label
        {
            Text = text,
            Location = new Point(x, y),
            Size = new Size(width, 24),
            ForeColor = TextColor,
            BackColor = Color.Transparent,
            AutoSize = false,
            UseMnemonic = false
        };
        parent.Controls.Add(label);
        return label;
    }

    private GroupBox AddGroup(string text, int x, int y, int width, int height)
    {
        var group = new GroupBox
        {
            Text = text,
            Location = new Point(x, y),
            Size = new Size(width, height),
            ForeColor = Color.FromArgb(220, 226, 232),
            BackColor = PanelColor
        };
        Controls.Add(group);
        return group;
    }

    private CheckBox AddCheck(Control parent, string text, int x, int y, int width)
    {
        var check = new CheckBox
        {
            Text = text,
            Location = new Point(x, y),
            Size = new Size(width, 26),
            ForeColor = TextColor,
            BackColor = Color.Transparent,
            AutoSize = false,
            UseMnemonic = false
        };
        parent.Controls.Add(check);
        return check;
    }

    private ComboBox AddCombo(Control parent, int x, int y, int width, string[] items)
    {
        var combo = new ComboBox
        {
            DropDownStyle = ComboBoxStyle.DropDownList,
            Location = new Point(x, y),
            Size = new Size(width, 26),
            FlatStyle = FlatStyle.Flat,
            BackColor = Color.FromArgb(245, 246, 248),
            ForeColor = BackgroundColor,
            MaxDropDownItems = 5
        };
        combo.Items.AddRange(items);
        parent.Controls.Add(combo);
        return combo;
    }

    private void HandleSliderChange(object sender, EventArgs args)
    {
        for (var i = 0; i < sliders.Length; i++)
            readouts[i].Text = sliders[i].Value + "%";
        if (!loading)
            ScheduleSave();
    }

    private void HandleOptionChange(object sender, EventArgs args)
    {
        if (loading)
            return;
        UpdateEnabledStates();
        ScheduleSave();
    }

    private void UpdateEnabledStates()
    {
        var physics = skirtPhysics.Checked;
        skirtSelfCollision.Enabled = physics;
        var selfCollision = physics && skirtSelfCollision.Checked;
        collisionScope.Enabled = selfCollision;
        precision.Enabled = physics;
        SetLabelEnabled(scopeLabel, selfCollision);
        SetLabelEnabled(precisionLabel, physics);

        var barefoot = !shoesVisible.Checked;
        barefootPose.Enabled = barefoot;
        barefootHeight.Enabled = barefoot;
        SetLabelEnabled(heightLabel, barefoot);
        SetLabelEnabled(heightUnit, barefoot);
        SetLabelEnabled(heightHint, barefoot);
    }

    private static void SetLabelEnabled(Label label, bool enabled)
    {
        label.Enabled = enabled;
        label.ForeColor = enabled ? TextColor : DisabledColor;
    }

    private void ScheduleSave()
    {
        saveTimer.Stop();
        saveTimer.Start();
    }

    private void HandleReset()
    {
        var defaults = settings.CreateDefaults();
        loading = true;
        ApplySettings(defaults);
        loading = false;
        UpdateEnabledStates();
        SaveNow();
    }

    private void ApplySettings(PanelSettingsData data)
    {
        sliders[0].Value = data.Hair;
        sliders[1].Value = data.Chest;
        sliders[2].Value = data.Skirt;
        for (var i = 0; i < sliders.Length; i++)
            readouts[i].Text = sliders[i].Value + "%";

        skirtPhysics.Checked = data.SkirtPhysics;
        skirtSelfCollision.Checked = data.SkirtSelfCollision;
        collisionScope.SelectedIndex =
            data.SkirtCollisionScope == PanelSettings.ScopeAll ? 1 : 0;
        precision.SelectedIndex = data.SkirtPrecision == PanelSettings.PrecisionLow ? 0 :
            data.SkirtPrecision == PanelSettings.PrecisionHigh ? 2 : 1;
        shoesVisible.Checked = data.ShoesVisible;
        barefootPose.Checked = data.BarefootPose;
        backWeaponsVisible.Checked = data.BackWeaponsVisible;

        barefootHeight.DecimalPlaces = DecimalPlacesFor(data.BarefootHeightCm);
        decimal height;
        try { height = (decimal)data.BarefootHeightCm; }
        catch (OverflowException) { height = 0m; }
        if (height < barefootHeight.Minimum) height = barefootHeight.Minimum;
        if (height > barefootHeight.Maximum) height = barefootHeight.Maximum;
        barefootHeight.Value = height;
    }

    private PanelSettingsData CaptureSettings()
    {
        var data = new PanelSettingsData();
        data.Hair = sliders[0].Value;
        data.Chest = sliders[1].Value;
        data.Skirt = sliders[2].Value;
        data.SkirtPhysics = skirtPhysics.Checked;
        data.SkirtSelfCollision = skirtSelfCollision.Checked;
        data.SkirtCollisionScope = collisionScope.SelectedIndex == 1
            ? PanelSettings.ScopeAll : PanelSettings.ScopeAdjacent;
        data.SkirtPrecision = precision.SelectedIndex == 0 ? PanelSettings.PrecisionLow :
            precision.SelectedIndex == 2 ? PanelSettings.PrecisionHigh : PanelSettings.PrecisionNormal;
        data.ShoesVisible = shoesVisible.Checked;
        data.BarefootPose = barefootPose.Checked;
        data.BarefootHeightCm = (double)barefootHeight.Value;
        data.BackWeaponsVisible = backWeaponsVisible.Checked;
        return data;
    }

    private void SaveNow()
    {
        saveTimer.Stop();
        try
        {
            settings.Write(CaptureSettings());
            SetSaveHint("设置已自动保存", Color.FromArgb(132, 190, 154));
        }
        catch (IOException)
        {
            SetSaveHint("保存失败，请稍后再试", Color.FromArgb(235, 120, 110));
        }
        catch (UnauthorizedAccessException)
        {
            SetSaveHint("设置目录不可写，无法保存", Color.FromArgb(235, 120, 110));
        }
        catch (InvalidOperationException)
        {
            SetSaveHint("设置值无效，未保存", Color.FromArgb(235, 120, 110));
        }
    }

    private void SetSaveHint(string text, Color color)
    {
        saveHint.Text = text;
        saveHint.ForeColor = color;
    }

    private void RefreshStatus()
    {
        string text = null;
        try
        {
            if (File.Exists(statusPath))
            {
                using (var stream = new FileStream(statusPath, FileMode.Open,
                    FileAccess.Read, FileShare.ReadWrite | FileShare.Delete))
                using (var reader = new StreamReader(stream, Encoding.UTF8, true))
                {
                    var buffer = new char[4096];
                    var count = reader.Read(buffer, 0, buffer.Length);
                    text = new string(buffer, 0, count);
                }
            }
        }
        catch (IOException)
        {
            return;
        }
        catch (UnauthorizedAccessException)
        {
            return;
        }

        if (text == null)
            text = "等待游戏应用设置";
        else
            text = text.Trim();
        if (text.Length == 0)
            text = "等待游戏应用设置";

        if (text.StartsWith("format=YounuoF8Status/1", StringComparison.Ordinal))
        {
            if (text.IndexOf("status=applied", StringComparison.Ordinal) >= 0)
                text = "已应用到当前角色";
            else if (text.IndexOf("status=error", StringComparison.Ordinal) >= 0)
                text = "部分设置未应用，请查看运行记录";
            else
                text = "等待角色或对应资源就绪";
        }
        text = text.Replace("\r", " ").Replace("\n", " ");
        while (text.IndexOf("  ", StringComparison.Ordinal) >= 0)
            text = text.Replace("  ", " ");
        if (text.Length > 80)
            text = text.Substring(0, 80) + "…";
        status.Text = text;
    }

    private static int DecimalPlacesFor(double value)
    {
        for (var places = 1; places <= 4; places++)
        {
            if (Math.Abs(Math.Round(value, places) - value) < 1e-9)
                return places;
        }
        return 4;
    }
}

internal static class SelfTest
{
    internal static int Run()
    {
        var report = new StringBuilder();
        var failed = 0;
        var root = Path.Combine(Path.GetTempPath(),
            "YounuoPhysicsPanel_selftest_" + Guid.NewGuid().ToString("N"));
        var settingsPath = Path.Combine(root, "settings.txt");
        var defaultsPath = Path.Combine(root, "defaults.txt");

        Action<string, bool> check = delegate(string name, bool ok)
        {
            report.AppendLine((ok ? "PASS " : "FAIL ") + name);
            if (!ok)
                failed++;
        };

        try
        {
            Directory.CreateDirectory(root);
            var settings = new PanelSettings(settingsPath);
            PanelSettingsData data;
            bool migration;

            check("missing settings uses defaults",
                settings.TryRead(out data, out migration) && !migration &&
                IsDefault(data, 0));

            WriteText(settingsPath, "12  50\t100\n");
            check("legacy three-number format accepted",
                settings.TryRead(out data, out migration) && migration &&
                data.Hair == 12 && data.Chest == 50 && data.Skirt == 100);
            check("legacy keeps other defaults",
                data.SkirtPhysics && data.SkirtSelfCollision &&
                data.SkirtCollisionScope == PanelSettings.ScopeAdjacent &&
                data.SkirtPrecision == PanelSettings.PrecisionNormal &&
                data.ShoesVisible && data.BarefootPose && data.BackWeaponsVisible &&
                data.BarefootHeightCm == 0);
            settings.Write(data);
            var migrated = File.ReadAllText(settingsPath, Encoding.UTF8);
            check("legacy saved as v2",
                migrated.StartsWith("version=2", StringComparison.Ordinal) &&
                migrated.IndexOf("hair=12", StringComparison.Ordinal) >= 0 &&
                migrated.IndexOf("chest=50", StringComparison.Ordinal) >= 0 &&
                migrated.IndexOf("skirt=100", StringComparison.Ordinal) >= 0);
            check("v2 write has no BOM", !HasBom(settingsPath));
            check("atomic write leaves no temp file", !File.Exists(settingsPath + ".tmp"));
            check("legacy migration reads back",
                settings.TryRead(out data, out migration) && !migration &&
                data.Hair == 12 && data.Chest == 50 && data.Skirt == 100);

            data.Hair = 7;
            data.Chest = 88;
            data.Skirt = 0;
            data.SkirtPhysics = false;
            data.SkirtSelfCollision = false;
            data.SkirtCollisionScope = PanelSettings.ScopeAll;
            data.SkirtPrecision = PanelSettings.PrecisionHigh;
            data.ShoesVisible = false;
            data.BarefootPose = false;
            data.BarefootHeightCm = 13.7;
            data.BackWeaponsVisible = false;
            settings.Write(data);
            check("v2 complete round trip",
                settings.TryRead(out data, out migration) && !migration &&
                data.Hair == 7 && data.Chest == 88 && data.Skirt == 0 &&
                !data.SkirtPhysics && !data.SkirtSelfCollision &&
                data.SkirtCollisionScope == PanelSettings.ScopeAll &&
                data.SkirtPrecision == PanelSettings.PrecisionHigh &&
                !data.ShoesVisible && !data.BarefootPose && !data.BackWeaponsVisible &&
                Math.Abs(data.BarefootHeightCm - 13.7) < 1e-9);

            var freshSettings = new PanelSettings(
                Path.Combine(root, "fresh", "settings.txt"));
            freshSettings.Write(PanelSettings.CreateDefaults(2.5));
            check("first write creates a v2 file",
                freshSettings.TryRead(out data, out migration) && !migration &&
                IsDefault(data, 2.5));
            check("first write has no BOM", !HasBom(freshSettings.SettingsPath));

            WriteText(defaultsPath, "barefoot_height_cm=4.5\n");
            WriteText(settingsPath, "version=2\nhair=33\n");
            check("missing fields fall back to defaults and factory height",
                settings.TryRead(out data, out migration) && !migration &&
                data.Hair == 33 && data.Chest == 50 && data.Skirt == 50 &&
                data.SkirtPhysics && data.SkirtSelfCollision &&
                data.SkirtCollisionScope == PanelSettings.ScopeAdjacent &&
                data.SkirtPrecision == PanelSettings.PrecisionNormal &&
                data.ShoesVisible && data.BarefootPose && data.BackWeaponsVisible &&
                Math.Abs(data.BarefootHeightCm - 4.5) < 1e-9);
            check("reset factory height comes from defaults.txt",
                Math.Abs(settings.CreateDefaults().BarefootHeightCm - 4.5) < 1e-9);

            WriteText(settingsPath, "version=2\nfuture_option=anything\nhair=41\n");
            check("unknown key is ignored",
                settings.TryRead(out data, out migration) &&
                data.Hair == 41 && data.Chest == 50);

            Action<string, string> reject = delegate(string name, string body)
            {
                WriteText(settingsPath, body);
                PanelSettingsData rejected;
                bool rejectedMigration;
                check("reject " + name,
                    !settings.TryRead(out rejected, out rejectedMigration) && rejected == null);
            };
            reject("non-boolean", "version=2\nskirt_physics=2\n");
            reject("barefoot pose non-boolean", "version=2\nbarefoot_pose=2\n");
            reject("duplicate barefoot pose", "version=2\nbarefoot_pose=0\nbarefoot_pose=1\n");
            reject("invalid collision scope", "version=2\nskirt_collision_scope=diagonal\n");
            reject("invalid precision", "version=2\nskirt_precision=ultra\n");
            reject("slider above range", "version=2\nhair=101\n");
            reject("negative slider", "version=2\nchest=-1\n");
            reject("height NaN", "version=2\nbarefoot_height_cm=NaN\n");
            reject("height infinity", "version=2\nbarefoot_height_cm=Infinity\n");
            reject("height above range", "version=2\nbarefoot_height_cm=20.1\n");
            reject("height exponent", "version=2\nbarefoot_height_cm=1e1\n");
            reject("unknown version", "version=3\n");
            reject("malformed key line", "version=2\nhair=50\n50\n");
            reject("legacy out of range", "12 50 101");

            WriteText(settingsPath, "version=2\n");
            check("bare v2 header uses all defaults",
                settings.TryRead(out data, out migration) &&
                IsDefault(data, 4.5));

            WriteText(defaultsPath, "barefoot_height_cm=not-a-number\n");
            check("invalid factory height falls back to zero",
                Math.Abs(settings.CreateDefaults().BarefootHeightCm) < 1e-9);

            WriteText(defaultsPath, "barefoot_height_cm=4.5\n");
            WriteText(settingsPath, "12 50 100\n");
            check("legacy format receives factory height",
                settings.TryRead(out data, out migration) && migration &&
                Math.Abs(data.BarefootHeightCm - 4.5) < 1e-9);
        }
        catch (Exception exception)
        {
            report.AppendLine("FAIL unexpected exception: " + exception);
            failed++;
        }
        finally
        {
            try
            {
                if (Directory.Exists(root))
                    Directory.Delete(root, true);
            }
            catch (IOException) { }
            catch (UnauthorizedAccessException) { }
        }

        report.AppendLine(failed == 0
            ? "SELF-TEST PASSED"
            : "SELF-TEST FAILED: " + failed.ToString(CultureInfo.InvariantCulture));
        var output = report.ToString();
        try
        {
            var logPath = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "self-test.txt");
            File.WriteAllText(logPath, output, new UTF8Encoding(false));
        }
        catch (IOException) { }
        catch (UnauthorizedAccessException) { }
        try { Console.WriteLine(output); }
        catch (IOException) { }
        return failed == 0 ? 0 : 1;
    }

    private static bool IsDefault(PanelSettingsData data, double height)
    {
        return data != null &&
            data.Hair == 50 && data.Chest == 50 && data.Skirt == 50 &&
            data.SkirtPhysics && data.SkirtSelfCollision &&
            data.SkirtCollisionScope == PanelSettings.ScopeAdjacent &&
            data.SkirtPrecision == PanelSettings.PrecisionNormal &&
            data.ShoesVisible && data.BarefootPose && data.BackWeaponsVisible &&
            Math.Abs(data.BarefootHeightCm - height) < 1e-9;
    }

    private static void WriteText(string path, string text)
    {
        File.WriteAllText(path, text, new UTF8Encoding(false));
    }

    private static bool HasBom(string path)
    {
        var bytes = File.ReadAllBytes(path);
        return bytes.Length >= 3 &&
            bytes[0] == 0xEF && bytes[1] == 0xBB && bytes[2] == 0xBF;
    }
}
