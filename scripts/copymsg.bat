@echo off

set batdir=%~dp0
if not exist "%HOMEPATH%\.hasdoc\NUL" mkdir "%HOMEPATH%\.hasdoc"
if not exist "%HOMEPATH%\.hasdoc-gen\NUL" mkdir "%HOMEPATH%\.hasdoc-gen"
xcopy /s /y "%batdir%data\translations\*.msg" "%HOMEPATH%\.hasdoc"
xcopy /s /y "%batdir%src\subprojects\hasdoc-gen\data\translations\*.msg" "%HOMEPATH%\.hasdoc-gen"
