@echo off
set PAUSE_ERRORS=1
call bat\SetupSDK.bat
call bat\SetupApp.bat
 
echo. Generating .exe directory

::set AIR_PATH=..\Project\air
::set AIR_NAME=Game
set AIR_TARGET=-captive-runtime
set OPTIONS=
call adt -package -target bundle ..\Project\dist\%AIR_NAME% %AIR_PATH%\%AIR_NAME%%AIR_TARGET%.air

 
pause