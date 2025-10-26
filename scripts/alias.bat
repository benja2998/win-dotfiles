@rem alias.bat

@echo off

set "ESC="

if "%~1"=="" (
    doskey /macros
    exit /b
) else (
    if "%~1"=="/?" (
        echo %ESC%[1;4mHelp text for alias%ESC%[0m
        echo.
        echo alias /?         : Display this help message
        echo alias name=value : Create an alias
        echo alias            : Show defined aliases
        echo.
        echo %ESC%[1;4mCodes used for defining aliases%ESC%[0m
        echo.
        echo $T               : Command separator
        echo $1-9             : Parameters passed to the alias
        echo $*               : All parameters passed to the alias. Never use this!
        echo.
        echo %ESC%[1;4mExample usage of alias%ESC%[0m
        echo.
        echo $ alias test=cls
        echo $ cls /?
        cls /?
    ) else (
        set "valid="
        for /f "tokens=1* delims==" %%A in ("%*") do set "valid=%%B"
        if not defined valid (
            echo Run 'alias /?' for help.
            exit /b 1
        ) else (
            doskey %* $*
        )
    )
)
