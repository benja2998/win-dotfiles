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

set WT_SETTINGS=%LOCALAPPDATA%\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json
set DOTFILES_SETTINGS=%~dp0settings.json

rem Backup existing settings.json if it exists and is not a symlink
if exist "%WT_SETTINGS%" (
    dir "%WT_SETTINGS%" | find "<SYMLINK>" >nul
    if errorlevel 1 (
        rename "%WT_SETTINGS%" "settings.json.bak"
    )
)

rem Remove existing settings.json if it is a file or broken symlink
if exist "%WT_SETTINGS%" del "%WT_SETTINGS%"

rem Create symlink from dotfiles
mklink "%WT_SETTINGS%" "%DOTFILES_SETTINGS%"

echo Windows Terminal settings.json symlinked to dotfiles.

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
