@echo off
title Windows 10 Auto Setup
cls
echo ============================================== | tee -a C:\SetupLog.txt
echo        Windows 10 Auto Installation          | tee -a C:\SetupLog.txt
echo ============================================== | tee -a C:\SetupLog.txt

:: Ensure Admin Privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Please run this script as Administrator! | tee -a C:\SetupLog.txt
    pause
    exit
)

:: Log File Setup
set LOGFILE=C:\SetupLog.txt
echo Setup Started: %date% %time% > %LOGFILE%

:: 1. Install Drivers
echo Installing Required Drivers... | tee -a %LOGFILE%
pnputil /add-driver "C:\Drivers\*.inf" /subdirs /install | tee -a %LOGFILE%
echo Drivers Installed Successfully! | tee -a %LOGFILE%

:: 2. Install .NET Framework
echo Installing .NET Framework 4.8... | tee -a %LOGFILE%
DISM /Online /Enable-Feature /FeatureName:NetFx4 /All | tee -a %LOGFILE%
echo Installing .NET Framework 3.5... | tee -a %LOGFILE%
DISM /Online /Enable-Feature /FeatureName:NetFx3 /All | tee -a %LOGFILE%

:: 3. Activate Windows 10
echo Activating Windows... | tee -a %LOGFILE%
slmgr /upk | tee -a %LOGFILE%
slmgr /ipk W269N-WFGWX-YVC9B-4J6C9-T83GX | tee -a %LOGFILE%
slmgr /skms kms8.msguides.com | tee -a %LOGFILE%
slmgr /ato | tee -a %LOGFILE%
echo Windows Activated Successfully! | tee -a %LOGFILE%

:: 4. Activate Microsoft Office (Requires Office Installed)
echo Activating Microsoft Office... | tee -a %LOGFILE%
cd /d %ProgramFiles%\Microsoft Office\Office16
cscript ospp.vbs /sethst:kms8.msguides.com | tee -a %LOGFILE%
cscript ospp.vbs /act | tee -a %LOGFILE%
echo Office Activated Successfully! | tee -a %LOGFILE%

:: 5. Install Browsers (Mozilla Firefox, Brave, Chrome)
echo Installing Mozilla Firefox... | tee -a %LOGFILE%
powershell -Command "& {Invoke-WebRequest -Uri 'https://download.mozilla.org/?product=firefox-latest&os=win&lang=en-US' -OutFile firefox_installer.exe}" | tee -a %LOGFILE%
start /wait firefox_installer.exe /silent | tee -a %LOGFILE%
del firefox_installer.exe

echo Installing Brave Browser... | tee -a %LOGFILE%
powershell -Command "& {Invoke-WebRequest -Uri 'https://laptop-updates.brave.com/latest/winx64' -OutFile brave_installer.exe}" | tee -a %LOGFILE%
start /wait brave_installer.exe /silent | tee -a %LOGFILE%
del brave_installer.exe

echo Installing Google Chrome... | tee -a %LOGFILE%
powershell -Command "& {Invoke-WebRequest -Uri 'https://dl.google.com/chrome/install/latest/chrome_installer.exe' -OutFile chrome_installer.exe}" | tee -a %LOGFILE%
start /wait chrome_installer.exe /silent | tee -a %LOGFILE%
del chrome_installer.exe

:: 6. Restart PC
echo Installation Complete. Restarting PC in 10 seconds... | tee -a %LOGFILE%
timeout /t 10
shutdown /r /t 0
