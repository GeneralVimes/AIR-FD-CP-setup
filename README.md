# Cross-platform AIR/FlashDevelop setup
libraries - useful 3rd party libraires, like junkbyte console
CommonCode - all the code which will be common in all platforms
Project-.../src - platform-specific part for each project

 Project-Windows
 Build for Windows
 1. Generate certificate by running bat/CreateCertificate.bat (needed only once)
 2. Set correct path to AIR SDK in bat/SetupSDK.bat
 3. Run bat/PackageApp.bat to create .air file
 4. Run exePackager.bat to greate a portable .exe version
 
 Project-Android
 Build for Android
  1. Generate certificate by running bat/CreateCertificate.bat (needed only once)
  2. Set correct path to AIR SDK in bat/SetupSDK.bat
  3. Run bat/PackageApp.bat, select 3-3 to make a 64-bit apk, 3-4 to create .aab bundle
  
  Project-iOS
 Build for iOS
 1. Get developer certificate .p12 from Apple
 2. Register the id from application.xml on Apple
 3. Get .mobileprovision files for Distribution, AdHoc and Development from Apple
 4. Input certificates names into bat/SeupApp.bat in :: iOS packaging
 5. Set correct path to AIR SDK in bat/SetupSDK.bat
 6. Run bat/PackageApp.bat, select 8 to make Ad-Hoc or 9 for App-Store build
 
 Project - folder for the resulting and intermadiate files
 Project/bin - compiled .swf file will be placed here when you run the project. Everything elese which you will place here will be packaged together with swf and will be available in the resulting windows, Android or iOS project
 Project/dist - all the files which you will build will appear here
 