@echo off

rem This is made to be used in the "Ultimate Doom" folder, and with a "GZDoom" folder present inside of it.
rem The Old Launcher requires the IWADs to be present in the "base" folder.
rem This is highly customizable, as long as the rules are being followed.

setlocal EnableDelayedExpansion

set "BASETITLE=Steam Doom Launcher by AkiraJkr and Mad"
title %BASETITLE%

ECHO Which launcher do you want to use?
ECHO 1.GZDoom Launcher(Not Ready Yet)
ECHO 2.Zandronum Launcher(Not Ready Yet)
ECHO 3.Old GZDoom Launcher
ECHO 4.Old Zandronum Launcher

CHOICE /C 1234 /M "Enter your choice:"

IF ERRORLEVEL 4 GOTO oldzandronumlauncher
IF ERRORLEVEL 3 GOTO oldgzdoomlauncher
IF ERRORLEVEL 2 GOTO zandronum
IF ERRORLEVEL 1 GOTO gzdoom

:gzdoom
START @powershell.exe -ExecutionPolicy Unrestricted -File  "%~dp0\GZDoom_Launcher.ps1"

:Zandronum
ECHO This is not even done yet, get out
pause
exit

:oldgzdoomlauncher
setx DOOMWADDIR "%~dp0base"
cls
echo Registering IWAD variables for GZDoom on "base" folder. Skip if it's not your first time.
timeout /t 5

ECHO Do you want to play GZDoom in:
ECHO 1. Singleplayer
ECHO 2. Multiplayer

CHOICE /C 12 /M "Enter your choice:"

IF ERRORLEVEL 2 GOTO multiplayersetup
IF ERRORLEVEL 1 GOTO singleplayersetup

:multiplayersetup
cls

echo Are you a...
echo 1. Client
echo 2. Server Host

CHOICE /C 12 /M "Enter your choice:"

IF ERRORLEVEL 2 GOTO multiplayerhost
IF ERRORLEVEL 1 GOTO multiplayerclient

:multiplayerclient
cls

set /p ipaddress="Enter the server's IP Address: "

set /p port="Enter the port to be used or leave blank for default(10666): "

if not defined ipaddress goto multiplayerclient

if not defined port set port=10666

echo You will be joining the server %ipaddress:"=%:%port%
pause
goto multiplayergamepickerclient

:multiplayerhost
cls

set /p port="Enter the port to be used or leave blank for default(10666): "

if not defined port set port=10666

set /p playernumbers=Set the number of players that will join your game: 

echo %playernumbers% players will be able to join your game. Wait until everyone joins.

goto multiplayergamepickerhost

:multiplayergamepickerclient

ECHO Which version of DOOM do you wish to start? [This] means it requires a certain IWAD present.
ECHO 1.Vanilla DOOM
ECHO 2.Brutal DOOM v21
ECHO 3.Project Brutality v2
ECHO 4.Doom 4 Vanilla
ECHO 5.Hellshots Golf[Doom2]
ECHO 6.Doom 64
ECHO Or else...
ECHO 7 to cancel the Launcher. You could just, like press that X on this console window. Please. Stop. Get some help.

CHOICE /C 1234567 /M "Enter your choice:"

:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 7 GOTO End
IF ERRORLEVEL 6 GOTO doom64multiplayerclient
IF ERRORLEVEL 5 GOTO hellshotsgolfmultiplayerclient
IF ERRORLEVEL 4 GOTO d4vmultiplayerclient
IF ERRORLEVEL 3 GOTO projectbrutalitymultiplayerclient
IF ERRORLEVEL 2 GOTO brutaldoommultiplayerclient
IF ERRORLEVEL 1 GOTO doommultiplayerclient

:doommultiplayerclient
    echo Initializing GZDoom Client
    START "" ".\GZDoom\gzdoom.exe" -join %ipaddress:"=%:%port%
	exit

:brutaldoommultiplayerclient
    echo Initializing GZDoom Client
    START "" ".\GZDoom\gzdoom.exe" ".\base\brutalv21.pk3" -join %ipaddress:"=%:%port%
	exit

:projectbrutalitymultiplayerclient
    echo Initializing GZDoom Client
    START "" ".\GZDoom\gzdoom.exe" -file .\base\Project_Brutality-master.zip -join %ipaddress:"=%:%port%
	exit

:d4vmultiplayerclient
    echo Initializing GZDoom Client
    START "" ".\GZDoom\gzdoom.exe" ".\base\D4V.wad" -join %ipaddress:"=%:%port%
	exit

:hellshotsgolfmultiplayerclient
    echo Initializing GZDoom Client
    START "" ".\GZDoom\gzdoom.exe" ".\base\hellshots_golf-v1.1.pk3" -join %ipaddress:"=%:%port%
	exit

:doom64multiplayerclient
    echo Initializing GZDoom Client
    START "" ".\GZDoom\gzdoom.exe" ".\base\DOOM64.WAD" -join %ipaddress:"=%:%port%
	exit

:multiplayergamepickerhost

ECHO Which version of DOOM do you wish to start? [This] means it requires a certain IWAD present.
ECHO 1.Vanilla DOOM
ECHO 2.Brutal DOOM v21
ECHO 3.Project Brutality v2
ECHO 4.Doom 4 Vanilla
ECHO 5.Hellshots Golf[Doom2]
ECHO 6.Doom 64
ECHO Or else...
ECHO 7 to cancel the Launcher. You could just, like press that X on this console window. Please. Stop. Get some help.

CHOICE /C 1234567 /M "Enter your choice:"

:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 7 GOTO End
IF ERRORLEVEL 6 GOTO doom64multiplayerhost
IF ERRORLEVEL 5 GOTO hellshotsgolfmultiplayerhost
IF ERRORLEVEL 4 GOTO d4vmultiplayerhost
IF ERRORLEVEL 3 GOTO projectbrutalitymultiplayerhost
IF ERRORLEVEL 2 GOTO brutaldoommultiplayerhost
IF ERRORLEVEL 1 GOTO doommultiplayerhost

:doommultiplayerhost
    echo Initializing GZDoom Client and Host
    START "" ".\GZDoom\gzdoom.exe"  -host %playernumbers% -port %port%
	exit

:brutaldoommultiplayerhost
    echo Initializing GZDoom Client and Host
    START "" ".\GZDoom\gzdoom.exe" ".\base\brutalv21.pk3" -host %playernumbers% -port %port%
	exit

:projectbrutalitymultiplayerhost
    echo Initializing GZDoom Client and Host
    START "" ".\GZDoom\gzdoom.exe" -file .\base\Project_Brutality-master.zip -host %playernumbers% -port %port%
	exit
	
:d4vmultiplayerhost
    echo Initializing GZDoom Client and Host
    START "" ".\GZDoom\gzdoom.exe" ".\base\D4V.wad" -host %playernumbers% -port %port%
	exit

:hellshotsgolfmultiplayerhost
    echo Initializing GZDoom Client and Host
    START "" ".\GZDoom\gzdoom.exe" ".\base\hellshots_golf-v1.1.pk3" -host %playernumbers% -port %port%
	exit

:doom64multiplayerhost
    echo Initializing GZDoom Client and Host
    START "" ".\GZDoom\gzdoom.exe" ".\base\DOOM64.WAD" -host %playernumbers% -port %port%
	exit
	
:singleplayersetup
ECHO Which version of DOOM do you wish to start? [This] means it requires a certain game.
ECHO 1.Vanilla DOOM
ECHO 2.Brutal DOOM v21
ECHO 3.Project Brutality v2
ECHO 4.Doom 4 Vanilla
ECHO 5.Hellshots Golf[Doom2]
ECHO 6.Doom 64
ECHO Or else...
ECHO 7 to cancel the Launcher. You could just, like press that X on this console window. Please. Stop. Get some help.

CHOICE /C 1234567 /M "Enter your choice:"

:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 7 GOTO exit
IF ERRORLEVEL 6 GOTO doom64
IF ERRORLEVEL 5 GOTO hellshotsgolf
IF ERRORLEVEL 4 GOTO d4v
IF ERRORLEVEL 3 GOTO projectbrutality
IF ERRORLEVEL 2 GOTO brutaldoom
IF ERRORLEVEL 1 GOTO doom

:doom
START .\GZDoom\gzdoom.exe
exit

:brutaldoom
START .\GZDoom\gzdoom.exe ".\base\brutalv21.pk3"
exit

:projectbrutality
START .\GZDoom\gzdoom.exe ".\base\Project Brutality 2.03.pk3"
exit

:d4v
START .\GZDoom\gzdoom.exe ".\base\D4V.wad"
exit

:hellshotsgolf
START .\GZDoom\gzdoom.exe ".\base\hellshots_golf-v1.1.pk3"
exit

:doom64
START .\GZDoom\gzdoom.exe ".\base\DOOM64.WAD"
exit

:End
ECHO die
exit



:oldzandronumlauncher
setx DOOMWADDIR "%~dp0base"
cls
echo Registering IWAD variables for Zandronum on "base" folder. Skip if it's not your first time.
timeout /t 5

:zanmultiplayersetup
cls

echo Are you a...
echo 1. Client
echo 2. Server Host

CHOICE /C 12 /M "Enter your choice:"

IF ERRORLEVEL 2 GOTO zanmultiplayerhost
IF ERRORLEVEL 1 GOTO zanmultiplayerclient

:zanmultiplayerclient
cls

set /p ipaddress="Enter the server's IP Address: "

set /p port="Enter the port to be used or leave blank for default(10666): "

if not defined ipaddress goto zanmultiplayerclient

if not defined port set port=10666

echo You will be joining the server %ipaddress:"=%:%port%
pause
goto zanmultiplayergamepickerclient

:zanmultiplayerhost
cls

set /p port="Enter the port to be used or leave blank for default(10666): "

if not defined port set port=10666

set /p playernumbers=Set the number of players that will join your game: 

echo %playernumbers% players will be able to join your game. Wait until everyone joins.

goto zanmultiplayergamepickerhost

:zanmultiplayergamepickerclient

ECHO Which version of DOOM do you wish to start? [This] means it requires a certain IWAD present.
ECHO 1.Vanilla DOOM
ECHO 2.Brutal DOOM v21
ECHO 3.Project Brutality v2
ECHO 4.Doom 4 Vanilla
ECHO 5.Hellshots Golf[Doom2]
ECHO 6.Doom 64
ECHO Or else...
ECHO 7 to cancel the Launcher. You could just, like press that X on this console window. Please. Stop. Get some help.

CHOICE /C 1234567 /M "Enter your choice:"

:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 7 GOTO End
IF ERRORLEVEL 6 GOTO zandoom64multiplayerclient
IF ERRORLEVEL 5 GOTO zanhellshotsgolfmultiplayerclient
IF ERRORLEVEL 4 GOTO zand4vmultiplayerclient
IF ERRORLEVEL 3 GOTO zanprojectbrutalitymultiplayerclient
IF ERRORLEVEL 2 GOTO zanbrutaldoommultiplayerclient
IF ERRORLEVEL 1 GOTO zandoommultiplayerclient

:zandoommultiplayerclient
    echo Initializing Zandronum Client
    START "" ".\Zandronum\zandronum.exe" -connect %ipaddress:"=%:%port% -width 1280 -height 720
	exit

:zanbrutaldoommultiplayerclient
    echo Initializing Zandronum Client
    START "" ".\Zandronum\zandronum.exe" ".\base\brutalv21.11.3.pk3" -connect %ipaddress:"=%:%port% -width 1280 -height 720
	exit

:zanprojectbrutalitymultiplayerclient
    echo Initializing Zandronum Client
    START "" ".\Zandronum\zandronum.exe" -file .\base\PB3Zv1.0.2-FINAL.pk3 -connect %ipaddress:"=%:%port% -width 1280 -height 720
	exit

:zand4vmultiplayerclient
    echo Initializing Zandronum Client
    START "" ".\Zandronum\zandronum.exe" ".\base\D4V.wad" -connect %ipaddress:"=%:%port% -width 1280 -height 720
	exit

:zanhellshotsgolfmultiplayerclient
    echo Initializing Zandronum Client
    START "" ".\Zandronum\zandronum.exe" ".\base\hellshots_golf-v1.1.pk3" -connect %ipaddress:"=%:%port% -width 1280 -height 720
	exit

:zandoom64multiplayerclient
    echo Initializing Zandronum Client
    START "" ".\Zandronum\zandronum.exe" ".\base\DOOM64.WAD" -connect %ipaddress:"=%:%port% -width 1280 -height 720
	exit

:zanmultiplayergamepickerhost

ECHO Which version of DOOM do you wish to start? [This] means it requires a certain IWAD present.
ECHO 1.Vanilla DOOM
ECHO 2.Brutal DOOM v21
ECHO 3.Project Brutality v2
ECHO 4.Doom 4 Vanilla
ECHO 5.Hellshots Golf[Doom2]
ECHO 6.Doom 64
ECHO Or else...
ECHO 7 to cancel the Launcher. You could just, like press that X on this console window. Please. Stop. Get some help.

CHOICE /C 1234567 /M "Enter your choice:"

:: Note - list ERRORLEVELS in decreasing order
IF ERRORLEVEL 7 GOTO End
IF ERRORLEVEL 6 GOTO zandoom64multiplayerhost
IF ERRORLEVEL 5 GOTO zanhellshotsgolfmultiplayerhost
IF ERRORLEVEL 4 GOTO zand4vmultiplayerhost
IF ERRORLEVEL 3 GOTO zanprojectbrutalitymultiplayerhost
IF ERRORLEVEL 2 GOTO zanbrutaldoommultiplayerhost
IF ERRORLEVEL 1 GOTO zandoommultiplayerhost

:zandoommultiplayerhost
    echo Initializing Zandronum Client and Host
    START "" ".\Zandronum\zandronum.exe"  -host %playernumbers% -port %port% -private -upnp -width 1280 -height 720
	exit

:zanbrutaldoommultiplayerhost
    echo Initializing Zandronum Client and Host
    START "" ".\Zandronum\zandronum.exe" ".\base\brutalv21.11.3.pk3" -host %playernumbers% -port %port% -private -upnp -width 1280 -height 720
	exit

:zanprojectbrutalitymultiplayerhost
    echo Initializing Zandronum Client and Host
    START "" ".\Zandronum\zandronum.exe" -file .\base\PB3Zv1.0.2-FINAL.pk3 -host %playernumbers% -port %port% -private -upnp -width 1280 -height 720
	exit
	
:zand4vmultiplayerhost
    echo Initializing Zandronum Client and Host
    START "" ".\Zandronum\zandronum.exe" ".\base\D4V.wad" -host %playernumbers% -port %port% -private -upnp -width 1280 -height 720
	exit

:zanhellshotsgolfmultiplayerhost
    echo Initializing Zandronum Client and Host
    START "" ".\Zandronum\zandronum.exe" ".\base\hellshots_golf-v1.1.pk3" -host %playernumbers% -port %port% -private -upnp -width 1280 -height 720
	exit

:zandoom64multiplayerhost
    echo Initializing Zandronum Client and Host
    START "" ".\Zandronum\zandronum.exe" ".\base\DOOM64.WAD" -host %playernumbers% -port %port% -private -upnp -width 1280 -height 720
	exit

:End
	ECHO die
	exit
