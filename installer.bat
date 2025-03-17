@echo off
title HostsMatic Installer v0.4 (mirbyte)
setlocal enabledelayedexpansion


>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
if %errorlevel% neq 0 (
    echo Requesting administrative privileges...
    goto UACPrompt
) else (
    goto gotAdmin
)

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
    "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    if exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )
    pushd "%CD%"
    CD /D "%~dp0"


set INSTALL_DIR=%ProgramFiles%\Hostsmatic
set SCRIPT_NAME=hostsmatic.exe
set HOSTS_FILE=C:\Windows\System32\drivers\etc\hosts
set HOSTS_BACKUP=C:\Windows\System32\drivers\etc\hosts.original.backup

echo Hostsmatic Installer
echo ===================
echo.


if not exist "%INSTALL_DIR%" (
    echo Creating installation directory...
    mkdir "%INSTALL_DIR%"
) else (
    echo Installation directory already exists.
	pause
)


echo Copying files to installation directory...
copy /Y "%~dp0%SCRIPT_NAME%" "%INSTALL_DIR%\%SCRIPT_NAME%"


if exist "%~dp0uninstaller.bat" (
    echo Copying uninstaller...
    copy /Y "%~dp0uninstaller.bat" "%INSTALL_DIR%\uninstaller.bat"
)

if not exist "%HOSTS_BACKUP%" (
    echo Creating original hosts file backup...
    copy /Y "%HOSTS_FILE%" "%HOSTS_BACKUP%"
)

:: Create shortcut in startup folder
echo Adding to startup...
echo Set oWS = WScript.CreateObject("WScript.Shell") > "%temp%\createshortcut.vbs"
echo sLinkFile = "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\Hostsmatic.lnk" >> "%temp%\createshortcut.vbs"
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> "%temp%\createshortcut.vbs"
echo oLink.TargetPath = "%INSTALL_DIR%\%SCRIPT_NAME%" >> "%temp%\createshortcut.vbs"
echo oLink.Arguments = "auto-update" >> "%temp%\createshortcut.vbs"
echo oLink.Description = "Hostsmatic - Automatic Hosts File Manager" >> "%temp%\createshortcut.vbs"
echo oLink.WorkingDirectory = "%INSTALL_DIR%" >> "%temp%\createshortcut.vbs"
echo oLink.Save >> "%temp%\createshortcut.vbs"
cscript //nologo "%temp%\createshortcut.vbs"
del "%temp%\createshortcut.vbs"

echo.
echo Installation complete!
echo.
echo Running Hostsmatic for initial setup...


:: Check if installation was successful
if not exist "%INSTALL_DIR%\%SCRIPT_NAME%" (
    echo ERROR: Installation failed. The program file was not copied correctly.
    echo Please check permissions and try again.
    pause
    exit /b 1
)

timeout /t 2 >nul
cls

:: Run the initial setup
cd /d "%INSTALL_DIR%"
"%SCRIPT_NAME%"
if %errorlevel% neq 0 (
    cls
    echo ERROR: Hostsmatic encountered an error during initial setup.
    echo Error code: %errorlevel%
    pause
)

endlocal