@echo off
:: ============================================
::  Disable Windows Update Script
::  Author: Foysal, Dhaka, Bangladesh
::  Date: %date% %time%
:: ============================================

echo Stopping Windows Update service...
net stop wuauserv

echo Disabling Windows Update service...
sc config wuauserv start= disabled

echo Stopping Background Intelligent Transfer Service...
net stop bits

echo Disabling Background Intelligent Transfer Service...
sc config bits start= disabled

echo Stopping Delivery Optimization Service...
net stop dosvc

echo Disabling Delivery Optimization Service...
sc config dosvc start= disabled

echo Check the service active or not


echo.
echo ✅ Windows Update has been completely disabled.
echo Restart your computer to apply the changes.
pause
