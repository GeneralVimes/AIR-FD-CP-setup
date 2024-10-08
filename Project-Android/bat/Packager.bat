@echo off

:: Set working dir
cd %~dp0 & cd ..

if "%PLATFORM%"=="android" goto android-config
if "%PLATFORM%"=="ios" goto ios-config
if "%PLATFORM%"=="ios-dist" goto ios-dist-config
goto start

:android-config
set CERT_FILE=%AND_CERT_FILE%
set SIGNING_OPTIONS=%AND_SIGNING_OPTIONS%
set ICONS=%AND_ICONS%
set DIST_EXT=apk
set TYPE=apk

:: which architecture?
echo.
echo Please select your target architecture for Android:
echo.
echo [1] armv7 ^(32-bit ARM devices^)
echo [2] x86 ^(Intel products^)
echo [3] armv8 ^(64-bit ARM devices^)
echo [4] Bundle
echo.
set /P ARCH=[Choice:]
echo.
if "%ARCH%"=="1" set OPTIONS=%OPTIONS% -arch armv7
if "%ARCH%"=="2" set OPTIONS=%OPTIONS% -arch x86
if "%ARCH%"=="3" set OPTIONS=%OPTIONS% -arch armv8

if "%ARCH%"=="1" set BITS=x32
if "%ARCH%"=="2" set BITS=x86
if "%ARCH%"=="3" set BITS=x64

if "%ARCH%"=="4" goto bundle

goto start

:ios-config
set CERT_FILE=%IOS_DEV_CERT_FILE%
set SIGNING_OPTIONS=%IOS_DEV_SIGNING_OPTIONS%
set ICONS=%IOS_ICONS%
set DIST_EXT=ipa
set TYPE=ipa
goto start
:: Set working dir
cd %~dp0 & cd ..

:ios-dist-config
set CERT_FILE=%IOS_DIST_CERT_FILE%
set SIGNING_OPTIONS=%IOS_DIST_SIGNING_OPTIONS%
set ICONS=%IOS_ICONS%
set DIST_EXT=ipa
set TYPE=ipa
goto start

:start
if not exist "%CERT_FILE%" goto certificate
:: Output file
set FILE_OR_DIR=%FILE_OR_DIR% -C "%ICONS%" .
if not exist "%DIST_PATH%" md "%DIST_PATH%"
set OUTPUT=%DIST_PATH%\%DIST_NAME%%TARGET%-%BITS%.%DIST_EXT%
:: Package
echo Packaging: %OUTPUT%
echo using certificate: %CERT_FILE%...
echo.
call adt -package -target %TYPE%%TARGET% %OPTIONS% %SIGNING_OPTIONS% "%OUTPUT%" "%APP_XML%" %FILE_OR_DIR%
::-resdir bin/res
echo.
if errorlevel 1 goto failed
goto end

:bundle
if not exist "%CERT_FILE%" goto certificate
:: Output file
set DIST_EXT=aab
set TYPE=aab
set FILE_OR_DIR=%FILE_OR_DIR% -C "%ICONS%" .
if not exist "%DIST_PATH%" md "%DIST_PATH%"
set OUTPUT=%DIST_PATH%\%DIST_NAME%%TARGET%.%DIST_EXT%
:: Package
echo Packaging Bundle: %OUTPUT%
echo using certificate: %CERT_FILE%...
echo.

call adt -package -target aab %SIGNING_OPTIONS% %OUTPUT% "%APP_XML%" %FILE_OR_DIR% -extdir lib/adt 

echo.
if errorlevel 1 goto failed
goto end
:certificate
echo Certificate not found: %CERT_FILE%
echo.
echo Android: 
echo - generate a default certificate using 'bat\CreateCertificate.bat'
echo   or configure a specific certificate in 'bat\SetupApp.bat'.
echo.
echo iOS: 
echo - configure your developer key and project's Provisioning Profile
echo   in 'bat\SetupApp.bat'.
echo.
if %PAUSE_ERRORS%==1 pause
exit

:failed
echo APK setup creation FAILED.
echo.
echo Troubleshooting: 
echo - verify AIR SDK target version in %APP_XML%
echo.
if %PAUSE_ERRORS%==1 pause
exit

:end

