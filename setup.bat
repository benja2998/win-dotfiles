@echo off
set "target=%~dp0.autorun.bat"

net session >nul 2>&1

if errorlevel 1 (
    echo Requesting administrative privileges...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

echo Press any key to continue with dotfiles setup...
pause >nul

reg add "HKCU\Software\Microsoft\Command Processor" /v AutoRun /d "\"%target%\"" /f

echo AutoRun for Command Prompt set to: %target%

rem Ensure Neovim config directory exists
if not exist "%LOCALAPPDATA%\nvim" (
    echo Creating Neovim config directory...
    mkdir "%LOCALAPPDATA%\nvim"
)

rem Create symlinks for dotfiles
move /y "%LOCALAPPDATA%\nvim\init.lua" "%LOCALAPPDATA%\nvim\init.lua.backup"
del /f /q "%LOCALAPPDATA%\nvim\init.lua"
mklink "%LOCALAPPDATA%\nvim\init.lua" "%~dp0init.lua"

echo Symlink for Neovim init.lua created.

rem Install programs
winget install -e --id sharkdp.bat
winget install -e --id eza-community.eza
winget install -e --id gerardog.gsudo
winget install -e --id ajeetdsouza.zoxide

echo Programs installed.

rem Set up powershell

powershell -executionpolicy Bypass -noprofile -nologo -command "%~dp0install.ps1"

echo Symlink for PowerShell profile created.

echo Dotfiles setup complete.
pause >nul
