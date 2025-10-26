@echo off

if "%~1"=="" (
    cd /d "%USERPROFILE%"
    zoxide add "%cd%"
    exit /b
)

if exist "%*" (
    cd /d "%*"
    zoxide add "%cd%"
    exit /b
)

for /f "usebackq delims=" %%i in (`zoxide query "%*" 2^>nul`) do (
    if errorlevel 1 (
        echo zoxide error
        exit /b 1
    )
    cd /d "%%i"
    exit /b
)
