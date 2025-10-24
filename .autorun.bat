@echo off
chcp 65001 >nul

rem Check for admin
net session >nul 2>&1
if %errorlevel%==0 (
    set "IS_ADMIN=1"
) else (
    set "IS_ADMIN=0"
)

rem Set a bash-like prompt
if "%IS_ADMIN%"=="0" (
   prompt $E[32m%USERNAME%@%COMPUTERNAME%$E[0m $E[34m$P$E[0m $$$S
) else (
   prompt $E[31m%USERNAME%$E[0m@%COMPUTERNAME% $P #$S
)

rem Set environment variables
set EDITOR=nvim
set "HOME=%USERPROFILE%"

rem Define aliases
doskey pwd=cd
doskey sudo=gsudo $*
doskey su=gsudo
doskey sudo.ti=gsudo --ti $* & rem TrustedInstaller
doskey sudo.system=gsudo -s $* & rem SYSTEM
doskey alias=doskey /macros
doskey vim=nvim $*
doskey clear=cls
doskey clr=cls
doskey rm=del /Q $*
doskey mv=move $*
doskey cp=copy $*
doskey cat=bat -pP $*
doskey ls=eza --color=auto $*
doskey ll=eza -lha --color=auto $*
doskey la=eza -a --color=auto $*
doskey l=eza -lh --color=auto $*
doskey which=where $*
doskey e.=explorer .

rem Modify PATH
set "PATH=%~dp0scripts;%PATH%"
