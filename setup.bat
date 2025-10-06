@echo off
set "target=%~dp0.autorun.bat"

echo Press any key to continue with dotfiles setup...
pause >nul

reg add "HKCU\Software\Microsoft\Command Processor" /v AutoRun /d "\"%target%\"" /f

echo AutoRun for Command Prompt set to: %target%
