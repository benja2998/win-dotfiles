@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

set "HISTFILE=%USERPROFILE%\.cmd_history"
set "TMPFILE=%TEMP%\trimhist.tmp"

if not exist "%HISTFILE%" exit /b 0

rem Create empty temp file
type nul > "%TMPFILE%"

for /f "usebackq delims=" %%A in ("%HISTFILE%") do (
    set "LINE=%%A"
    call :AddUnique
)

move /y "%TMPFILE%" "%HISTFILE%" >nul
exit /b 0

:AddUnique
for /f "usebackq delims=" %%B in ("%TMPFILE%") do (
    if "%%B"=="!LINE!" exit /b
)
echo !LINE!>>"%TMPFILE%"
exit /b
