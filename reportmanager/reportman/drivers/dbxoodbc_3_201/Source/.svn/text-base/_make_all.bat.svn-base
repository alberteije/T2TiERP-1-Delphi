@echo off

set compiler=%1
if "%compiler%" == "" set compiler=7

rem compiler:
rem 6 - Delphi 6
rem 7 - Delphi 7
rem 9 - Delphi 9 Win32

call _make_driver_debug.bat %compiler%
  if "%ERROR_STATE%"=="1" exit
call _make_driver_release.bat %compiler%
