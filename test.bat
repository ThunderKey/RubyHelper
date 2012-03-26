@echo off
IF NOT EXIST "%~dp0ruby.conf" GOTO get_path

:run
FOR /f %%x IN ('type ruby.conf') DO %%x "%~dpn0.rb"
pause
GOTO:EOF

:get_path
set /p ruby_path=Enter the path of ruby: 
echo %ruby_path% > "%~dp0ruby.conf"
cls
GOTO run