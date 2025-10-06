@echo off

:: Set working dir
cd %~dp0 & cd ..

set PAUSE_ERRORS=1
call bat\SetupSDK.bat
call bat\SetupApp.bat

mxmlc ../CommonCode/src/Main.as -source-path+=../CommonCode/src/ -source-path+=../_libraries/junkbyte/ -source-path+=src -o ../Project/bin/Game.swf