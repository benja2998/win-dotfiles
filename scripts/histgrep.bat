@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

set "HISTFILE=%USERPROFILE%\.cmd_history"

if not exist "%HISTFILE%" (
    echo No history file found at "%HISTFILE%"
    exit /b 1
)

if "%~1"=="" (
    echo Usage: histcmd ^<search-term^>
    exit /b 1
)

set "SEARCH=%*"
set COUNT=0

echo Searching history for "%SEARCH%"...
echo.

for /f "usebackq delims=" %%A in (`findstr /i "%SEARCH%" "%HISTFILE%"`) do (
    set /a COUNT+=1
    echo %%A
)
echo.

if %COUNT%==0 (
    echo No matches found.
    exit /b 1
)

echo You may copy the command that you want to execute.
