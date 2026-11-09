param([string]$GameDirectory = $PSScriptRoot, [string]$OutputPath)
$ErrorActionPreference = 'Stop'
if (Get-Process PBZ -ErrorAction SilentlyContinue) { throw 'Close PBZ before changing ReShade settings.' }
if (![IO.File]::Exists((Join-Path $GameDirectory 'PBZ.exe'))) { throw 'Place this tool beside PBZ.exe.' }
$ini = Join-Path $GameDirectory 'ReShade.ini'
$exists = [IO.File]::Exists($ini)
$original = if ($exists) { [IO.File]::ReadAllText($ini) } else { '' }
$newline = if ($original.Contains("`r`n") -or !$original.Contains("`n")) { "`r`n" } else { "`n" }
$settings = [ordered]@{
    TutorialProgress = 4
    ShowFPS = 0
    ShowClock = 0
    ShowFrameTime = 0
    ShowPresetTransitionMessage = 0
    ShowScreenshotMessage = 0
}
$overlay = [regex]::new('(?ims)^[ \t]*\[OVERLAY\][ \t]*\r?(?:\n|$).*?(?=^[ \t]*\[[^\]\r\n]+\][ \t]*\r?$|\z)')
$section = $overlay.Match($original)
$body = if ($section.Success) { $section.Value } else { '[OVERLAY]' + $newline }
foreach ($key in $settings.Keys) {
    $assignment = [regex]::new('(?im)^[ \t]*' + $key + '[ \t]*=[^\r\n]*')
    $value = "$key=$($settings[$key])"
    if ($assignment.IsMatch($body)) { $body = $assignment.Replace($body, $value) }
    else { $body = $body.TrimEnd("`r", "`n") + $newline + $value + $newline }
}
$updated = if ($section.Success) {
    $original.Substring(0, $section.Index) + $body + $original.Substring($section.Index + $section.Length)
} else { $original.TrimEnd("`r", "`n") + $(if ($original) { $newline + $newline }) + $body }
if (!$OutputPath) {
    if ($updated -ceq $original) { return }
    if ($exists) {
        $backup = $ini + '.bak_younuo_' + (Get-Date -Format 'yyyyMMdd_HHmmss_fff')
        [IO.File]::Copy($ini, $backup)
        Write-Host "Backup: $([IO.Path]::GetFileName($backup))"
    }
    $OutputPath = $ini
}
[IO.File]::WriteAllText($OutputPath, $updated, [Text.UTF8Encoding]::new($false))
