@echo off
setlocal
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%~dp0HideReShadeNotifications.ps1"
if errorlevel 1 (
    echo Could not update ReShade settings.
) else (
    echo ReShade tutorial and notifications are disabled. Start the game again.
)
pause
