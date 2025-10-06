@echo off
chcp 65001 >nul

rem This file automatically runs with CMD, as defined in AutoRun registry key.

rem Set a bash-like prompt
prompt $E[32m%USERNAME%@%COMPUTERNAME%$E[0m:$E[34m$P$E[0m$$ 

rem Set environment variables
set EDITOR=nvim

rem Define aliases
doskey vim=nvim $*
doskey ls=dir/b
doskey ll=dir/a
doskey la=dir/b/a
doskey l=dir
doskey clear=cls
doskey clr=cls
doskey cat=type $*
