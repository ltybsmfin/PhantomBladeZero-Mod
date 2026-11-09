param(
    [ValidateSet('Install','Uninstall')][string]$Mode = 'Install',
    [string]$GameRoot,
    [ValidateSet('Core','Toon')][string]$Edition,
    [switch]$AcceptUnverifiedGraphics,
    [switch]$RemoveAddedDependencies
)
$ErrorActionPreference = 'Stop'
$packageRoot = Split-Path -Parent $PSScriptRoot

function Hash($Path) { (Get-FileHash -LiteralPath $Path -Algorithm SHA256).Hash }
function Inside([string]$Root, [string]$Relative) {
    if ($Relative -notmatch '^[A-Za-z0-9_.~/-]+$' -or $Relative -match '(^|/)\.{1,2}(/|$)|^/|//') {
        throw "无效的相对路径：$Relative"
    }
    $current = $Root
    foreach ($part in $Relative.Split('/')) {
        $current = Join-Path $current $part
        if (Test-Path -LiteralPath $current) {
            if ((Get-Item -LiteralPath $current -Force).Attributes -band [IO.FileAttributes]::ReparsePoint) {
                throw "目录包含链接或重定向，请选择实际游戏目录：$Relative"
            }
        }
    }
    $current
}

function Select-Game {
    Add-Type -AssemblyName System.Windows.Forms
    $dialog = New-Object Windows.Forms.FolderBrowserDialog
    $dialog.Description = '选择 Steam「浏览本地文件」打开的目录（里面有 ProjectPBZ 和 platform）'
    $dialog.ShowNewFolderButton = $false
    try {
        if ($dialog.ShowDialog() -eq [Windows.Forms.DialogResult]::OK) { $dialog.SelectedPath }
    } finally { $dialog.Dispose() }
}

function Assert-Closed {
    if (Get-Process PBZ,YounuoPhysicsPanel -ErrorAction SilentlyContinue) {
        throw '请先退出游戏和 F8 调节窗口，再运行本程序。'
    }
}

function Test-Graphics {
    try {
        Add-Type @"
using System;
using System.Runtime.InteropServices;
public static class YounuoGraphics {
    [DllImport("d3d12.dll")] static extern int D3D12CreateDevice(IntPtr adapter, int featureLevel, ref Guid iid, out IntPtr device);
    [UnmanagedFunctionPointer(CallingConvention.StdCall)]
    delegate int CheckFeature(IntPtr self, int feature, ref int model, int size);
    public static bool SupportsShader66() {
        Guid iid = new Guid("189819f1-1db6-4b57-be54-1821339b85f7");
        IntPtr device;
        if (D3D12CreateDevice(IntPtr.Zero, 0xb000, ref iid, out device) < 0) return false;
        try {
            IntPtr table = Marshal.ReadIntPtr(device);
            IntPtr method = Marshal.ReadIntPtr(table, 13 * IntPtr.Size);
            var check = (CheckFeature)Marshal.GetDelegateForFunctionPointer(method, typeof(CheckFeature));
            int model = 0x66;
            return check(device, 7, ref model, sizeof(int)) >= 0 && model >= 0x66;
        } finally { Marshal.Release(device); }
    }
}
"@
        [YounuoGraphics]::SupportsShader66()
    } catch { $false }
}

function Fetch($Name, $Url, $Sha) {
    $path = Join-Path $scratch $Name
    Write-Host "正在从官方发布页下载 $Name ..."
    $ProgressPreference = 'SilentlyContinue'
    Invoke-WebRequest -Uri $Url -OutFile $path -UseBasicParsing -TimeoutSec 120
    if ((Hash $path) -ne $Sha) { throw "$Name 校验失败，请使用说明里的官方下载页手动安装。" }
    $path
}

function Add-Dependency($Path, $Source, [switch]$KeepExisting) {
    $target = Inside $GameRoot $Path
    if ([IO.File]::Exists($target)) {
        if (!$KeepExisting -and (Hash $target) -ne (Hash $Source)) {
            throw "已有不同版本的 $Path。为保留其他模组的配置，请按说明备份后手动处理。"
        }
        return
    }
    $plan.Add([pscustomobject]@{path=$Path;source=$Source;sha=(Hash $Source);dependency=$true})
}

function Read-Archive($Archive, $Map) {
    foreach ($key in $Map.Keys) {
        $entry = $Archive.GetEntry($key)
        if ($null -eq $entry) { throw "官方前置缺少 $key" }
        $file = Join-Path $scratch ([Guid]::NewGuid().ToString('N'))
        [IO.Compression.ZipFileExtensions]::ExtractToFile($entry, $file)
        Add-Dependency $Map[$key] $file -KeepExisting:($key -eq 'ue4ss/UE4SS-settings.ini')
    }
}

function Copy-Zip($ArchivePath, $Map) {
    $zip = [IO.Compression.ZipFile]::OpenRead($ArchivePath)
    try { Read-Archive $zip $Map } finally { $zip.Dispose() }
}

function Backup-File($Relative, $Source) {
    $backup = Inside $GameRoot "$backupRel/$Relative"
    [IO.Directory]::CreateDirectory([IO.Path]::GetDirectoryName($backup)) | Out-Null
    [IO.File]::Copy($Source, $backup)
    $backup
}

function Read-Receipt {
    if (Test-Path -LiteralPath $receipt) {
        try { Get-Content -LiteralPath $receipt -Raw -Encoding UTF8 | ConvertFrom-Json }
        catch { Write-Warning '安装记录无法读取，将按发布清单检查 Mod 文件。' }
    }
}

function Install-Mod {
    if (!$Edition) {
        Write-Host '1. 安装基础版（尤诺和 F8）'
        Write-Host '2. 安装基础版和卡通渲染'
        switch (Read-Host '输入 1 或 2，按 Enter') {
            '1' { $Edition = 'Core' }
            '2' { $Edition = 'Toon' }
            default { throw '已取消。' }
        }
    }
    if ($Edition -eq 'Toon') {
        $releaseKey = (Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full' -ErrorAction SilentlyContinue).Release
        if ($releaseKey -lt 528040) { throw '卡通版需要 .NET Framework 4.8。请从说明中的微软链接安装后重试。' }
        if (!(Test-Graphics)) {
            Write-Warning '未确认默认显卡支持 Direct3D 12 与 Shader Model 6.6。双显卡设备请确认游戏使用高性能显卡。'
            if (!$AcceptUnverifiedGraphics -and (Read-Host '仍要安装卡通版请输入 Y') -ne 'Y') { throw '已取消。可重新选择基础版。' }
        }
    }
    Write-Host '正在检查游戏目录和安装包 ...'
    $modFiles = @($manifest.files | Where-Object { $_.install_path -and ($_.layer -eq '01-Core' -or $Edition -eq 'Toon') })
    $expected = @($modFiles.install_path)
    $mods = Inside $GameRoot 'ProjectPBZ/Content/Paks/~mods'
    if (Test-Path -LiteralPath $mods) {
        $old = @(Get-ChildItem -LiteralPath $mods -File -Filter 'zzz_Younuo_*' | Where-Object {
            $_.Extension -in '.pak','.utoc','.ucas' -and "ProjectPBZ/Content/Paks/~mods/$($_.Name)" -notin $expected
        })
        if ($old.Count) { throw '发现其他版本的尤诺资源。请先按说明将旧资源移出 ~mods 并备份。' }
    }
    foreach ($item in $modFiles) {
        $source = Inside $packageRoot $item.archive_path
        if ((Hash $source) -ne $item.sha256) { throw "安装包文件缺失或校验失败：$($item.archive_path)" }
        $target = Inside $GameRoot $item.install_path
        if ($item.install_path -like '*/YounuoPhysicsPanel/settings.txt' -and [IO.File]::Exists($target)) { continue }
        $plan.Add([pscustomobject]@{path=$item.install_path;source=$source;sha=$item.sha256;dependency=$false})
    }
    $depRoot = 'platform/steam'
    $sig = @{
        'dsound.dll'="$depRoot/dsound.dll"
        'UniversalSigBypasser.asi'="$depRoot/UniversalSigBypasser.asi"
    }
    $ue = @{}
    foreach ($leaf in @('dwmapi.dll','ue4ss/UE4SS.dll','ue4ss/UE4SS-settings.ini','ue4ss/MemberVariableLayout.ini',
            'ue4ss/UE4SS_Signatures/GNatives.lua','ue4ss/UE4SS_Signatures/GUObjectArray.lua',
            'ue4ss/Mods/shared/UEHelpers/UEHelpers.lua','ue4ss/LICENSE')) { $ue[$leaf] = "$depRoot/$leaf" }
    if (@($sig.Values | Where-Object { !(Test-Path -LiteralPath (Inside $GameRoot $_) -PathType Leaf) }).Count) {
        $file = Fetch 'SigBypasser_v1.2.zip' 'https://github.com/rm-NoobInCoding/UniversalSigBypasser/releases/download/v1.2/SigBypasser_v1.2.zip' 'C2A1F2D72AA2B7C5C47B1074D589C358D5A1BC5812CC48980AF6BA57BBBFA344'
        Copy-Zip $file $sig
    }
    if (@($ue.Values | Where-Object { !(Test-Path -LiteralPath (Inside $GameRoot $_) -PathType Leaf) }).Count) {
        $file = Fetch 'PBZ-UE4SS.zip' 'https://github.com/KintaroModding/ue4ss/releases/download/v3.0.1-1183-gcdbc0b66-r2/phantombladezero_ue4ss_v3.0.1-1183-gcdbc0b66-r2.zip' '3C90CCAD430C00079F4E9C7BE5468AE8670C3DE48F4DE8C21027D9A56347A028'
        Copy-Zip $file $ue
    }
    if ($Edition -eq 'Toon') {
        $dxgi = Inside $GameRoot "$depRoot/dxgi.dll"
        if ([IO.File]::Exists($dxgi)) {
            if ((Hash $dxgi) -ne 'EC9245D05C11751F2AC0D2256E6921AD8FB36BE9172EF6D587856591EB729A25') {
                throw '游戏目录已有其他版本的 dxgi.dll。请先备份现有 ReShade，或选择基础版。'
            }
        } else {
            $file = Fetch 'ReShade_6.7.3_Addon.exe' 'https://reshade.me/downloads/ReShade_Setup_6.7.3_Addon.exe' 'C78DB69BD127E98054BD496FB422655F4A1CC664E28F8D12CE9835B2647BC571'
            # Offset of the embedded ZIP in the exact, SHA-256 pinned installer.
            $data = [IO.File]::ReadAllBytes($file)
            $stream = [IO.MemoryStream]::new($data, 154624, $data.Length - 154624, $false)
            try {
                $zip = [IO.Compression.ZipArchive]::new($stream, [IO.Compression.ZipArchiveMode]::Read)
                try { Read-Archive $zip @{ 'ReShade64.dll'="$depRoot/dxgi.dll" } } finally { $zip.Dispose() }
            } finally { $stream.Dispose() }
        }
        $dxc = @{ 'bin/x64/dxcompiler.dll'="$depRoot/dxcompiler.dll"; 'bin/x64/dxil.dll'="$depRoot/dxil.dll" }
        if (@($dxc.Values | Where-Object { !(Test-Path -LiteralPath (Inside $GameRoot $_) -PathType Leaf) }).Count) {
            $file = Fetch 'DXC-x64.zip' 'https://github.com/microsoft/DirectXShaderCompiler/releases/download/v1.9.2602/dxc_2026_02_20.zip' 'A1E89031421CF3C1FCA6627766AB3020CA4F962AC7E2CAA7FAB2B33A8436151E'
            Copy-Zip $file $dxc
        }
        $null = Inside $GameRoot "$depRoot/ReShade.ini"
        $helper = $plan | Where-Object path -eq "$depRoot/HideReShadeNotifications.ps1"
        $settings = Join-Path $scratch 'ReShade.ini'
        & $helper.source -GameDirectory (Inside $GameRoot $depRoot) -OutputPath $settings
        $plan.Add([pscustomobject]@{path="$depRoot/ReShade.ini";source=$settings;sha=(Hash $settings);dependency=$false})
    }
    Assert-Closed
    $previous = Read-Receipt
    $owned = @{}
    foreach ($oldEntry in @($previous.dependencies)) {
        if ($oldEntry -and $oldEntry.path) { $owned[$oldEntry.path] = $oldEntry }
    }
    $changes = [Collections.Generic.List[object]]::new()
    try {
        foreach ($item in $plan) {
            $target = Inside $GameRoot $item.path
            $backup = $null
            if ([IO.File]::Exists($target)) {
                if ((Hash $target) -eq $item.sha) { continue }
                if ($item.dependency) { throw "前置在安装过程中发生变化：$($item.path)" }
                $backup = Backup-File $item.path $target
            }
            [IO.Directory]::CreateDirectory([IO.Path]::GetDirectoryName($target)) | Out-Null
            $changes.Add([pscustomobject]@{target=$target;backup=$backup})
            [IO.File]::Copy($item.source, $target, $null -ne $backup)
            if ((Hash $target) -ne $item.sha) { throw "写入后校验失败：$($item.path)" }
            if ($item.dependency) { $owned[$item.path] = [pscustomobject]@{path=$item.path;sha=$item.sha} }
        }
        $state = [ordered]@{
            layers = @('01-Core'; if ($Edition -eq 'Toon' -or '02-Toon' -in $previous.layers) { '02-Toon' })
            dependencies = @($owned.Values)
        }
        $stagedReceipt = "$receipt.pending"
        if (Test-Path -LiteralPath $stagedReceipt) { throw '发现未完成的安装记录，请先备份该文件。' }
        try {
            $state | ConvertTo-Json -Depth 5 | Set-Content -LiteralPath $stagedReceipt -Encoding UTF8
            if ([IO.File]::Exists($receipt)) { [IO.File]::Replace($stagedReceipt, $receipt, [NullString]::Value) }
            else { [IO.File]::Move($stagedReceipt, $receipt) }
        } finally { if ([IO.File]::Exists($stagedReceipt)) { [IO.File]::Delete($stagedReceipt) } }
    } catch {
        for ($i = $changes.Count - 1; $i -ge 0; $i--) {
            $change = $changes[$i]
            if ($change.backup) { [IO.File]::Copy($change.backup, $change.target, $true) }
            elseif ([IO.File]::Exists($change.target)) { [IO.File]::Delete($change.target) }
        }
        throw
    }
    Write-Host '安装完成。请从 Steam 启动游戏，读档后按 F8。'
    if (Test-Path -LiteralPath (Join-Path $GameRoot $backupRel)) { Write-Host "旧文件备份：$backupRel" }
}

function Uninstall-Mod {
    $record = Read-Receipt
    $layers = if ($record.layers) { @($record.layers) } else { @('01-Core','02-Toon') }
    $items = @($manifest.files | Where-Object { $_.install_path -and $_.layer -in $layers })
    $dependencies = @($record.dependencies | Where-Object { $_ -and $_.path })
    $allowed = @('dsound.dll','UniversalSigBypasser.asi','dwmapi.dll','dxgi.dll','dxcompiler.dll','dxil.dll',
        'ue4ss/UE4SS.dll','ue4ss/UE4SS-settings.ini','ue4ss/MemberVariableLayout.ini','ue4ss/LICENSE',
        'ue4ss/UE4SS_Signatures/GNatives.lua','ue4ss/UE4SS_Signatures/GUObjectArray.lua',
        'ue4ss/Mods/shared/UEHelpers/UEHelpers.lua') | ForEach-Object { "platform/steam/$_" }
    $dependencies = @($dependencies | Where-Object { $_.path -in $allowed })
    if ($dependencies.Count -and !$RemoveAddedDependencies) {
        Write-Host '本工具以前安装过前置。如果其他 Mod 也在使用，直接按 Enter 保留。'
        $RemoveAddedDependencies = (Read-Host '要一并卸载这些前置请输入 Y') -eq 'Y'
    }
    Assert-Closed
    $removed = $missing = $failed = 0
    $remaining = [Collections.Generic.List[object]]::new()
    foreach ($item in $items) {
        try {
            $target = Inside $GameRoot $item.install_path
            if (![IO.File]::Exists($target)) { Write-Warning "缺失或已移走：$($item.install_path)"; $missing++; continue }
            if ((Hash $target) -ne $item.sha256) {
                $null = Backup-File $item.install_path $target
                Write-Warning "内容已更改，先备份再移除：$($item.install_path)"
            }
            [IO.File]::Delete($target)
            $removed++
        } catch { $failed++; Write-Warning $_.Exception.Message }
    }
    foreach ($entry in $dependencies) {
        try {
            $target = Inside $GameRoot $entry.path
            if (![IO.File]::Exists($target)) { Write-Warning "前置缺失或已移走：$($entry.path)"; $missing++; continue }
            if (!$RemoveAddedDependencies -or (Hash $target) -ne $entry.sha) {
                if ($RemoveAddedDependencies) { Write-Warning "前置已更改，已保留：$($entry.path)" }
                $remaining.Add($entry)
                continue
            }
            [IO.File]::Delete($target)
            $removed++
        } catch { $failed++; $remaining.Add($entry); Write-Warning $_.Exception.Message }
    }
    if ([IO.File]::Exists($receipt) -and $failed -eq 0) {
        if ($remaining.Count) {
            @{layers=$layers;dependencies=@($remaining.ToArray())} | ConvertTo-Json -Depth 5 |
                Set-Content -LiteralPath $receipt -Encoding UTF8
        } else { [IO.File]::Delete($receipt) }
    }
    Write-Host "已删除 $removed 个文件，缺失 $missing 个，未能移除 $failed 个。"
    if (Test-Path -LiteralPath (Join-Path $GameRoot $backupRel)) { Write-Host "已改动文件的备份：$backupRel" }
    if ($failed) { throw '有文件无法移除，可关闭占用文件的程序后重试。' }
}

$scratch = $null
try {
    if ($env:PROCESSOR_ARCHITECTURE -ne 'AMD64' -or [Environment]::OSVersion.Version.Major -lt 10) {
        throw '请在 Windows 10 或 11 x64 上运行。'
    }
    Assert-Closed
    if (!$GameRoot) { $GameRoot = Select-Game }
    if (!$GameRoot) { return }
    $GameRoot = (Resolve-Path -LiteralPath $GameRoot).Path
    if (!(Test-Path -LiteralPath (Inside $GameRoot 'platform/steam/PBZ.exe') -PathType Leaf) -or
        !(Test-Path -LiteralPath (Inside $GameRoot 'ProjectPBZ/Content/Paks') -PathType Container)) {
        throw '这里不是 Steam 游戏目录。请在 Steam 里选「管理 → 浏览本地文件」。'
    }
    $manifest = Get-Content -LiteralPath (Join-Path $packageRoot 'manifest.json') -Raw -Encoding UTF8 | ConvertFrom-Json
    $receipt = Inside $GameRoot 'YounuoInstallReceipt.json'
    $backupRel = 'YounuoInstallBackup/' + (Get-Date -Format 'yyyyMMdd-HHmmss') + '-' + [Guid]::NewGuid().ToString('N').Substring(0,8)
    if ($Mode -eq 'Uninstall') { Uninstall-Mod; return }
    $tempRoot = [IO.Path]::GetFullPath([IO.Path]::GetTempPath()).TrimEnd('\') + '\'
    $scratch = Join-Path $tempRoot ('YounuoDeploy-' + [Guid]::NewGuid().ToString('N'))
    [IO.Directory]::CreateDirectory($scratch) | Out-Null
    Add-Type -AssemblyName System.IO.Compression.FileSystem
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    $plan = [Collections.Generic.List[object]]::new()
    Install-Mod
} catch {
    Write-Host $_.Exception.Message -ForegroundColor Red
    exit 1
} finally {
    if ($scratch -and (Test-Path -LiteralPath $scratch)) {
        $resolved = (Resolve-Path -LiteralPath $scratch).Path
        if ($resolved.StartsWith($tempRoot,[StringComparison]::OrdinalIgnoreCase) -and
            [IO.Path]::GetFileName($resolved) -match '^YounuoDeploy-[a-f0-9]{32}$') {
            Remove-Item -LiteralPath $resolved -Recurse -Force
        }
    }
}
