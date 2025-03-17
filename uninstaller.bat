@echo off
title Hostsmatic Uninstaller v0.4 (mirbyte)


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

echo Hostsmatic Uninstaller
echo =====================
echo.


set INSTALL_DIR=%ProgramFiles%\Hostsmatic
set HOSTS_FILE=C:\Windows\System32\drivers\etc\hosts
set HOSTS_BACKUP=C:\Windows\System32\drivers\etc\hosts.original.backup


:: Simple confirmation
echo This will remove Hostsmatic from your system.
choice /C YN /M "Continue with uninstallation"
if errorlevel 2 goto :Cancelled

echo.
echo Uninstalling Hostsmatic...
echo.

:: Remove startup shortcut
echo Checking startup files...
if exist "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\Hostsmatic.lnk" (
    del "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\Hostsmatic.lnk"
    echo Startup shortcut removed.
)

:: Check for hosts backup
echo.
if exist "%HOSTS_BACKUP%" (
    choice /C YN /M "Restore original hosts file"
    if errorlevel 1 if not errorlevel 2 (
        copy /Y "%HOSTS_BACKUP%" "%HOSTS_FILE%"
        echo Hosts file restored.
    )
)

:: Remove program files
echo.
if exist "%INSTALL_DIR%" (
    echo Removing program files...
    
    :: First, try to terminate any running instances of hostsmatic.exe
    echo Checking for running instances of Hostsmatic...
    taskkill /F /IM hostsmatic.exe >nul 2>&1
    if %errorlevel% equ 0 (
        echo Terminated running Hostsmatic process.
    ) else (
        echo No running Hostsmatic process found.
    )
    
    :: Wait a moment
    timeout /t 2 >nul
    :: Now try to remove the directory
    rd /s /q "%INSTALL_DIR%" 2>nul
    
    :: Check if successful
    if exist "%INSTALL_DIR%" (
        echo Warning: Could not remove all files. Some may still be in use.
        echo You may need to restart your computer and run the uninstaller again.
    ) else (
        echo Program files removed successfully.
    )
)


echo.
if exist "%HOSTS_BACKUP%" (
    choice /C YN /M "Remove hosts backup file"
    if errorlevel 1 if not errorlevel 2 (
        del "%HOSTS_BACKUP%"
        echo Backup file removed.
    ) else (
        echo Backup file preserved at: %HOSTS_BACKUP%
    )
)

echo.
echo Hostsmatic has been uninstalled.
goto :End

:Cancelled
echo.
echo Uninstallation cancelled.

:End
echo.
echo Press any key to exit...
pause >nul