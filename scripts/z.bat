@echo off

if "%~1"=="" (
    cd /d "%USERPROFILE%"
    exit /b
)

if exist "%~1" (
    cd /d "%~1"
    zoxide add "%CD%"
    exit /b
)

for /f "usebackq delims=" %%i in (`zoxide query "%*"`) do (
    if errorlevel 1 (
        exit /b 1
    )
    cd /d "%%i"
    exit /b
)
