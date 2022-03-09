@echo off

rem This is made to be used in the "Ultimate Doom" folder, and with a "GZDoom" folder present inside of it.
rem The Old Launcher requires the IWADs to be present in the "base" folder.
rem This is highly customizable, as long as the rules are being followed.

setlocal EnableDelayedExpansion

set "BASETITLE=Steam Doom Launcher by AkiraJkr and Mad"
title %BASETITLE%

echo This is made to be used in the "Ultimate Doom" folder, and with a "GZDoom" folder present inside of it.
echo The Old Launcher requires the IWADs to be present in the "base" folder.

rem ECHO Which launcher do you want to use?
rem ECHO 1.GZDoom Launcher(Not Ready Yet)
rem ECHO 2.Zanondrum Launcher(Not Ready Yet)
rem ECHO 3.Old GZDoom Launcher
rem We don't need this, like why

rem CHOICE /C 123 /M "Enter your choice:"

rem IF ERRORLEVEL 3 GOTO oldgzdoomlauncher
rem IF ERRORLEVEL 2 GOTO zanondrum
rem IF ERRORLEVEL 1 GOTO gzdoom

rem :gzdoom
rem START @powershell.exe -ExecutionPolicy Unrestricted -File  "%~dp0\GZDoom_Launcher.ps1"
rem 
rem :zanondrum
rem ECHO This is not even done yet, get out
rem pause
rem exit
rem 
rem :oldgzdoomlauncher
setx DOOMWADDIR "%~dp0base"
rem This will set a DOOMWADDIR user environment variable, which will let GZDoom detect DOOM, and whatever WADs/mods you put there.
cls
echo Registering IWAD variables for GZDoom on "base" folder. Skip if it's not your first time.
timeout /t 5
rem Apparently, a NVMe SSD is not enough. I'm not kidding.

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
    START "" ".\GZDoom\gzdoom.exe" ".\base\Project Brutality 2.03.pk3" -join %ipaddress:"=%:%port%
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
    START "" ".\GZDoom\gzdoom.exe"  -host %playernumbers%
	exit

:brutaldoommultiplayerhost
    echo Initializing GZDoom Client and Host
    START "" ".\GZDoom\gzdoom.exe" ".\base\brutalv21.pk3" -host %playernumbers%
	exit

:projectbrutalitymultiplayerhost
    echo Initializing GZDoom Client and Host
    START "" ".\GZDoom\gzdoom.exe" ".\base\Project Brutality 2.03.pk3" -host %playernumbers%
	exit
	
:d4vmultiplayerhost
    echo Initializing GZDoom Client and Host
    START "" ".\GZDoom\gzdoom.exe" ".\base\D4V.wad" -host %playernumbers%
	exit

:hellshotsgolfmultiplayerhost
    echo Initializing GZDoom Client and Host
    START "" ".\GZDoom\gzdoom.exe" ".\base\hellshots_golf-v1.1.pk3" -host %playernumbers%
	exit

:doom64multiplayerhost
    echo Initializing GZDoom Client and Host
    START "" ".\GZDoom\gzdoom.exe" ".\base\DOOM64.WAD" -host %playernumbers%
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