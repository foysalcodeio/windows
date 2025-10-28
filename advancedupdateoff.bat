@echo off
:: ============================================
::  Windows Update Control Script
::  Author: Foysal, Dhaka, Bangladesh
::  Date: %date% %time%
:: ============================================

color 0A
echo ============================================
echo        Windows Update Control Script
echo ============================================
echo.

:: Ask user for action
echo Choose an option:
echo [1] Disable Windows Update
echo [2] Enable Windows Update
set /p choice=Enter your choice (1/2): 

if "%choice%"=="1" goto disable
if "%choice%"=="2" goto enable
echo Invalid choice.
pause
exit /b

:disable
color 0C
echo.
echo 🔴 Disabling Windows Update...
net stop wuauserv >nul 2>&1
sc config wuauserv start= disabled >nul 2>&1
net stop bits >nul 2>&1
sc config bits start= disabled >nul 2>&1
net stop dosvc >nul 2>&1
sc config dosvc start= disabled >nul 2>&1

echo.
echo ============================================
echo 🔴 Windows Update is now DISABLED!
echo ============================================
goto status

:enable
color 0A
echo.
echo 🟢 Enabling Windows Update...
sc config wuauserv start= auto >nul 2>&1
net start wuauserv >nul 2>&1
sc config bits start= auto >nul 2>&1
net start bits >nul 2>&1
sc config dosvc start= auto >nul 2>&1
net start dosvc >nul 2>&1

echo.
echo ============================================
echo 🟢 Windows Update is now ENABLED!
echo ============================================
goto status

:status
echo.
echo Checking Windows Update service status...
sc query wuauserv | find /i "STATE"
echo.
pause
exit
