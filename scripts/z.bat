@echo off

if "%~1"=="" (
    cd /d "%USERPROFILE%"
    zoxide add "%cd%"
    exit /b
)

if exist "%~1" (
    cd /d "%~1"
    zoxide add "%cd%"
    exit /b
)

for /f "usebackq delims=" %%i in (`zoxide query "%*"`) do (
    if errorlevel 1 (
        exit /b 1
    )
    cd /d "%%i"
    exit /b
)
