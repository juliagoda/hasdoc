@echo off

set batdir=%~dp0
if not exist "%HOMEPATH%\.hasdoc-gen\NUL" mkdir "%HOMEPATH%\.hasdoc-gen"
xcopy /s /y "%batdir%data\translations\*.msg" "%HOMEPATH%\.hasdoc-gen"
