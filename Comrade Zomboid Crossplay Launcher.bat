@echo off
setlocal enabledelayedexpansion
title Comrade Zomboid Crossplay Launcher (AppID 480)

echo ========================================================
echo   COMRADE ZOMBOID - CROSSPLAY LAUNCHER (BUILD 42)
echo ========================================================
echo.

:: 1. Check if running directly inside the Project Zomboid directory
if exist "%~dp0ProjectZomboid64.exe" (
    set "TARGET_DIR=%~dp0"
    goto :LAUNCH
)

:: 2. Check Steam Registry Install Location
for /f "tokens=2*" %%a in ('reg query "HKCU\Software\Valve\Steam" /v SteamPath 2^>nul') do (
    set "STEAM_ROOT=%%~b"
    set "STEAM_ROOT=!STEAM_ROOT:/=\!"
    if exist "!STEAM_ROOT!\steamapps\common\ProjectZomboid\ProjectZomboid64.exe" (
        set "TARGET_DIR=!STEAM_ROOT!\steamapps\common\ProjectZomboid"
        goto :LAUNCH
    )
)

:: 3. Check common Steam & Library drive paths
for %%D in (
    "C:\Program Files (x86)\Steam\steamapps\common\ProjectZomboid"
    "C:\Program Files\Steam\steamapps\common\ProjectZomboid"
    "D:\SteamLibrary\steamapps\common\ProjectZomboid"
    "E:\SteamLibrary\steamapps\common\ProjectZomboid"
    "F:\SteamLibrary\steamapps\common\ProjectZomboid"
    "G:\SteamLibrary\steamapps\common\ProjectZomboid"
    "D:\Games\Project Zomboid"
    "C:\Games\Project Zomboid"
) do (
    if exist "%%~D\ProjectZomboid64.exe" (
        set "TARGET_DIR=%%~D"
        goto :LAUNCH
    )
)

:: 4. If game directory not detected yet, check for ComradeInstaller.exe
if exist "%~dp0ComradeInstaller.exe" (
    echo [i] Project Zomboid installation not found automatically.
    echo [i] Starting Comrade Unified Installer to auto-detect and configure...
    start "" "%~dp0ComradeInstaller.exe"
    exit /b 0
)

echo [!] Could not locate ProjectZomboid64.exe automatically.
echo [!] Please run ComradeInstaller.exe or place this file in your Project Zomboid folder.
echo.
pause
exit /b 1

:LAUNCH
echo [x] Game Directory: "!TARGET_DIR!"
echo [x] Injecting Steam AppID 480 (Spacewar Crossplay Network)...
cd /d "!TARGET_DIR!"
set SteamAppId=480
set SteamGameId=480
start "" "ProjectZomboid64.exe"
echo [OK] Comrade Zomboid crossplay initiated. Have fun in Kentucky!
timeout /t 3 >nul
exit /b 0
