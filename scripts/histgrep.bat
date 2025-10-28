@echo off
chcp 65001 >nul
if "%~1"=="" (
    echo Usage: histgrep ^<search-term^>
    exit /b 1
)
findstr /i "%*" "%USERPROFILE%\.cmd_history%"
