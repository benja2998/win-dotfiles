@echo off

set "ESC="

echo %ESC%[1;4mhisthelp%ESC%[0m
echo.
echo savehist         : Save current command history to persistent history
echo histgrep         : Search for commands in persistent history
echo viewhist         : View contents of persistent history
echo clearhist        : Clear persistent history
echo trimhist         : Remove duplicates in persistent history
echo histhelp         : Show this help text
