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
set "COUNT=0"

echo Searching history for "%SEARCH%"...
echo.

for /f "usebackq delims=" %%A in (`findstr /i "%SEARCH%" "%HISTFILE%"`) do (
    set /a COUNT+=1
    echo [!COUNT!] %%A
    set "CMD[!COUNT!]=%%A"
)

if %COUNT%==0 (
    echo No matches found.
    exit /b 1
)

echo.
set /p "CHOICE=Enter number to execute (or press Enter to cancel): "

if "%CHOICE%"=="" (
    echo Cancelled.
    exit /b 0
)

if %CHOICE% leq 0 (
    echo Invalid choice.
    exit /b 1
)

if %CHOICE% gtr %COUNT% (
    echo Invalid choice.
    exit /b 1
)

set "RUN=!CMD[%CHOICE%]!"
echo.
echo Running: !RUN!
echo Warning: Aliases do not apply.
echo.

!RUN!
