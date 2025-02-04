@echo off
(
    :: Check Admin rights and create VBS Script to elevate to administrator
    >nul fsutil dirty query %SYSTEMDRIVE% 2>&1 || (

        :: Very little red console
        mode con cols=40 lines=3 
        color cf

        :: Message
        title Please wait...
        echo.
        echo  Requesting elevated shell...

        :: Create VBS script
        echo Set UAC = CreateObject^("Shell.Application"^)>"%TEMP%\elevate.vbs"
        echo UAC.ShellExecute "%~f0", "%TEMP%\elevate.vbs", "", "runas", 1 >>"%TEMP%\elevate.vbs"
        if exist "%TEMP%\elevate.vbs" start /b /wait >nul cscript /nologo "%TEMP%\elevate.vbs" 2>&1

        :: Delete elevation script if exist
        if exist "%TEMP%\elevate.vbs" >nul del /f "%TEMP%\elevate.vbs" 2>&1

        exit /b
    )    
)

pushd "%~dp0"

@echo off
REM Title of Window
title Welcome to the Advance System Util for Windows 11

:Start
        mode con cols=100 lines=60
color 5b
echo Welcome, %USERNAME%
echo Created By: Wizzard102
echo Creation Date: 04/04/19	Updated On: 02/03/25
echo Version: 2.9

echo.
echo NOTE: (*) You Will Need To Restart Computer
echo NOTE: (#) Powershell Script
echo.
echo What would you like to do today?
echo.
echo Tracking and Tracing Tools
echo 1. IP Trace
echo 2. URL Trace
echo 3. Port Checker
echo 4. Find all connections on lan
echo.
echo Network Card Tools
echo 5. DNS Flush (*)
echo 6. Network Driver Reset (*)
echo.
echo Windows OS tools
echo 7. Download Windows 11 latest Image 
echo 8. System File Checker (*)
echo 9. Check Disk for Errors and Repair (*)
echo 10. Show Task Manager
echo 11. Convert PID to Program Name (#)
echo 12. Kill Task Via PID (#)
echo 13. Hard Disk Device Info (#)
echo 14. Windows Version Number
echo 15. Windows Disk Cleanup
echo 16. Windows SSD Migration (#)(*)
echo.
echo App Updates
echo 17. Application Audit (#)
echo 18. ReRegister App (#)(*)
echo 19. Reinstall Built in Apps (#)(*)
echo 20. Windows Update Reset (#)(*)
echo 21. Stop/Start mDNSResponder for Bonjour (#)(*)
echo 22. Remove Windows Web Experience Pack  (#)
echo 23. Stop searchapp.exe (#)
echo.
echo Restart and Delete Files created via this batch file.
echo 24. System Restart
echo 25. Delete text files
echo.
echo NOTE: Detection of Vulnerability
echo scan has to launch before anything else above!!  
echo 26. Log4j Detection Scan (#)
echo 27. Nvidia Optimization
echo.
echo 0. Quit

pushd "%~dp0"

set /p choice="Enter your Choice: "
if "%choice%"=="1" goto Ping
if "%choice%"=="2" goto Tracert
if "%choice%"=="3" goto Port
if "%choice%"=="4" goto LANK
if "%choice%"=="5" goto DNS
if "%choice%"=="6" goto Net
if "%choice%"=="7" goto Image
if "%choice%"=="8" goto Checker
if "%choice%"=="9" goto Disk
if "%choice%"=="10" goto TSLT
if "%choice%"=="11" goto PROC
if "%choice%"=="12" goto KLTK
if "%choice%"=="13" goto HDINF
if "%choice%"=="14" goto WVN
if "%choice%"=="15" goto WDC
if "%choice%"=="16" goto WSSD
if "%choice%"=="17" goto SECA
if "%choice%"=="18" goto RAP1
if "%choice%"=="19" goto RIAP2
if "%choice%"=="20" goto WUCLU
if "%choice%"=="21" goto SSMDNS
if "%choice%"=="22" goto RWWEP
if "%choice%"=="23" goto SSAPP
if "%choice%"=="24" goto ShutDown
if "%choice%"=="25" goto DELTEXT
if "%choice%"=="26" goto Log4j
if "%choice%"=="27" goto nvdi
if "%choice%"=="0" exit
echo Invalid choice: %choice%
echo.
pause
cls
@echo off
goto Start


REM Start Ping Script
:Ping
cls
@echo off
goto :main

:get_ip
	echo :::Command Options for PathPing:::
	echo -n prevent pathping from resolving ips
	echo -h maxhops (max hops to use)
	echo -g hostlist (specifies that the echo request messages)
	echo -p milliseconds to wait
	echo -q num (echo requests sent)
	echo -w timeout (milliseconds to wait)
	echo -i ip (specifies source ip)
	echo -4 IPv4 Only
	echo -6 IPv6 Only
	echo.
 set /P "ip=Enter an IP address:"
 set /P "hop=Enter Command Options:"
goto :eof

:main
  setlocal 
    set ip=%a%
	set hop=%b%
    set output=ping.txt
    if "%ip%" == "" call :get_ip
    echo Pinging ip %ip%
    ping %ip% > %output%
    echo Running pathping on %ip% with %hop% options
    pathping %hop% %ip% >> %output%
    echo Finished.  See %output% for results.
  endlocal
pause
cls
@echo off
goto Start
REM End of Ping Script


REM Start Tracert Script
:Tracert
cls
@echo off
goto :trace
:get_url
	echo :::Command Options for Tracert:::
	echo -d (this prevents from resolving ips to host)
	echo -h Maxhops (max hops to use)
	echo -w timeout (max timeout in milliseconds)
	echo -4 use IPv4
	echo -6 use IPv6
	echo.
 set /P "url=Enter URL address:"
 set /P "opt=Enter Command Options:"
goto :eof

:trace
 setlocal
	set url=%c%
	set opt=%d%
	set output=url.txt
	if "%url%" == "" call :get_url
	echo Running Trace on %url% with %opt% Options
	tracert %opt% %url% > %output%
	echo Finished. See %output% for results.
 endlocal
pause
cls
@echo off
goto Start
REM End of Tracert Script


REM Start Port Checker Script
:Port
cls
@Echo off
 setlocal
	set output=portscan.txt
	echo Running Port Checker
	netstat -aonb > "%output%"
	echo Finished Port Checker See %output% for results.
 endlocal
echo.
pause
cls
@echo off
goto Start
REM End of Port Checker Script


REM Start DNS Flush Script
:DNS
cls
@Echo on
ipconfig /flushdns
echo.
pause
cls
@echo off
goto Start
REM End of DNS Flush Script


REM Start Network Driver Reset Script
:NET
cls
@Echo on
pushd C:\Windows\System32\drivers\etc
attrib -h -s -r hosts
echo 127.0.0.1 localhost>HOSTS
attrib +r +h +s hosts
popd
netsh winsock reset all
netsh int ip reset all
ipconfig /release
ipconfig /renew
arp -d *
nbtstat -R
nbtstat -RR
ipconfig /flushdns
ipconfig /registerdns
@echo off
goto Start
REM End of Network Driver Reset Script


REM Start Get latest Windows Image Script
:Image
cls
@Echo on
dism.exe /Online /Cleanup-Image /Restorehealth
pause
cls
@echo off
goto Start
REM End of Windows Image Script


REM Start System File Checker Script
:Checker
cls
@Echo on
sfc /scannow
pause
cls
@echo off
goto Start
REM end of File Checker Script


REM Start Checkdisk Script
:Disk
cls
@Echo off
goto :repair

:get_dsk
set /P "dsk=enter disk letter to repair:"
goto :eof

:repair
 setlocal
	set dsk=%e%
	if "%dsk%" == "" call :get_dsk
	echo Running Check Disk on %dsk%
	chkdsk %dsk%: /f /r /x
 endlocal
pause
cls
@echo off
goto Start
REM end of Checkdisk Script


REM Start Shutdown Script
:ShutDown
cls
@echo off
goto :SD

:Get_Answer
 set /P "Answer=Shutdown PC Now (yes/no):"
goto :eof

:SD
 setlocal
	set Answer=%f%
	if "%Answer%" == "" call :Get_Answer
	if "%Answer%" == "yes" (shutdown -r -t 1) else (goto CAP1)
:CAP1
	if "%Answer%" == "YES" (shutdown -r -t 1) else (goto CAP2)
:CAP2
	if "%Answer%" == "y" (shutdown -r -t 1) else (goto CAP3)
:CAP3
	if "%Answer%" == "Y" (shutdown -r -t 1) else (goto qend)
 endlocal
:qend
cls
@echo off
goto Start
REM End of Shutdown Script

REM Start Delete Text Files Script
:DELTEXT
cls
@echo off
 setlocal
	SET MYFILE1="%~dp0ping.txt" 
	IF EXIST %MYFILE1% DEL /F %MYFILE1%
	SET MYFILE2="%~dp0portscan.txt" 
	IF EXIST %MYFILE2% DEL /F %MYFILE2%
	SET MYFILE3="%~dp0url.txt" 
	IF EXIST %MYFILE3% DEL /F %MYFILE3%
	SET MYFILE4="%~dp0scanlan.txt" 
	IF EXIST %MYFILE4% DEL /F %MYFILE4%
	SET MYFILE5="%~dp0systeminfo.txt" 
	IF EXIST %MYFILE5% DEL /F %MYFILE5%
 endlocal
cls
@echo off
goto Start
REM end delete text files script

REM Start Finding All active ips on Lan
:LANK
cls
@echo off
 setlocal
	echo Scanning Intranet
	set output=scanlan.txt
	arp -a > "%output%"
	echo Refer to %output% for results
 endlocal
pause
cls
@echo off
goto Start
REM End Finding all active IP's on Lan

REM Start Security Audit Script
:SECA
cls
@echo off
powershell -executionpolicy Bypass -File "%~dp0scripts\Sec_APP\secaudit.ps1"
Echo if errors please refer to the following website for info
Echo https://www.wintips.org/fix-windows-shell-experience-host-deployment-failed-0x80073d02/
pause
cls
@echo off
goto Start
REM End of Security Audit Script

REM Start Hard Drive Info Script
:HDINF
cls
@echo off
powershell -ExecutionPolicy Bypass -File "%~dp0scripts\HardDiskInfo\HD-Device.ps1"
pause
cls
@echo off
goto Start
REM End of Hard Drive Info Script

REM Start Process Search
:PROC
cls
@echo off
goto :PID_1

:Get_SID
set /P "ID=Enter Program # to Lookup:"
goto :eof

:PID_1
 setlocal
	set ID=%g%
	if "%ID%" == "" call :Get_SID
	powershell -executionpolicy Bypass -File "%~dp0scripts\ID_App\process.ps1"  "%ID%"
 endlocal
pause
cls
@echo off
goto Start
REM End Process Search

REM Start Windows Version Number Search
:WVN
cls
@echo off
winver
 setlocal
	set output=systeminfo.txt
	echo  Running System Info Checker
	systeminfo > "%output%"
	echo Finished System Info Checker See %output% for results.
 endlocal
pause
cls
@echo off
goto Start
REM end Windows Version Number Search


REM Start Disk Cleanup
:WDC
cls
@echo off
cleanmgr
pause
cls
@echo off
goto Start
REM end of Disk Cleanup

REM Start Task Manager
:TSLT
cls
@echo off
taskmgr
pause
cls
@echo off
goto Start
REM end of Task Manager

REM Start Kill Task VIA PID
:KLTK
cls
@echo off
goto :ktsk

:get_kl
set /P "ID5=enter program # to end task:"
goto :eof

:ktsk
 setlocal
	set ID5=%h%
	if "%ID5%" == "" call :get_kl
	taskkill /F /PID %ID5%
 endlocal
pause
cls
goto Start
REM end kill task

REM Start Register App
:RAP1
cls
@echo off
goto :Ap1

:Get_App
set /P "App=Enter App Name:"
goto :eof

:Ap1
 setlocal
	set App=%i%
	if "%App%" == "" call :Get_App
	powershell -executionpolicy Bypass -File "%~dp0scripts\ReReg_APP\register_app.ps1" "%App%"
 endlocal
pause
cls
@echo off
goto Start
REM End Register App

REM Start SSD Migration
:WSSD
cls
@echo off
PowerShell -ExecutionPolicy Bypass -File "%~dp0scripts\WindowsSSDMigration\Run.ps1"
pause
cls
@echo off
goto Start
REM End SSD Migration

REM Start Windows Update Reset
:WUCLU
cls
@echo on
net stop bits
net stop wuauserv
net stop appidsvc
net stop cryptsvc
pause
Del "%ALLUSERSPROFILE%\Application Data\Microsoft\Network\Downloader\*.*"
rmdir %systemroot%\SoftwareDistribution /S /Q
rmdir %systemroot%\system32\catroot2 /S /Q
pause
sc.exe sdset bits D:(A;;CCLCSWRPWPDTLOCRRC;;;SY)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BA)(A;;CCLCSWLOCRRC;;;AU)(A;;CCLCSWRPWPDTLOCRRC;;;PU)
sc.exe sdset wuauserv D:(A;;CCLCSWRPWPDTLOCRRC;;;SY)(A;;CCDCLCSWRPWPDTLOCRSDRCWDWO;;;BA)(A;;CCLCSWLOCRRC;;;AU)(A;;CCLCSWRPWPDTLOCRRC;;;PU)
pause
cd /d %windir%\system32
regsvr32.exe /s atl.dll
regsvr32.exe /s urlmon.dll
regsvr32.exe /s mshtml.dll
regsvr32.exe /s shdocvw.dll
regsvr32.exe /s browseui.dll
regsvr32.exe /s jscript.dll
regsvr32.exe /s vbscript.dll
regsvr32.exe /s scrrun.dll
regsvr32.exe /s msxml.dll
regsvr32.exe /s msxml3.dll
regsvr32.exe /s msxml6.dll
regsvr32.exe /s actxprxy.dll
regsvr32.exe /s softpub.dll
regsvr32.exe /s wintrust.dll
regsvr32.exe /s dssenh.dll
regsvr32.exe /s rsaenh.dll
regsvr32.exe /s gpkcsp.dll
regsvr32.exe /s sccbase.dll
regsvr32.exe /s slbcsp.dll
regsvr32.exe /s cryptdlg.dll
regsvr32.exe /s oleaut32.dll
regsvr32.exe /s ole32.dll
regsvr32.exe /s shell32.dll
regsvr32.exe /s initpki.dll
regsvr32.exe /s wuapi.dll
regsvr32.exe /s wuaueng.dll
regsvr32.exe /s wuaueng1.dll
regsvr32.exe /s wucltui.dll
regsvr32.exe /s wups.dll
regsvr32.exe /s wups2.dll
regsvr32.exe /s wuweb.dll
regsvr32.exe /s qmgr.dll
regsvr32.exe /s qmgrprxy.dll
regsvr32.exe /s wucltux.dll
regsvr32.exe /s muweb.dll
regsvr32.exe /s wuwebv.dll
pause
netsh winsock reset
netsh winsock reset proxy
pause
net start bits
net start wuauserv
net start appidsvc
net start cryptsvc
pause
@echo off
goto Start
REM End of Windows Update Reset

REM Start Search Engine Stop
:SSAPP
cls
@echo on
cd /d %windir%\SystemApps
taskkill /f /im SearchHost.exe
pause
cls
@echo off
goto Start
REM End of Search Engine Stop

REM Start windows web experience pack Removal
:RWWEP
cls
@echo on
winget uninstall "windows web experience pack"
pause
cls
@echo off
goto Start
REM End Removal of windows web experience pack

REM Start MDNS start/stop
:SSMDNS
cls
@echo on
powershell -executionpolicy Bypass -File "%~dp0scripts\SS_MDNS\SS_MDNS.ps1"
pause
@echo off
goto Start
REM End MSDS start/stop

REM Start reinstall all built in apps
:RIAP2
cls
@echo on
powershell -executionpolicy Bypass -File "%~dp0scripts\ReInstall_APPS\RIAP2.ps1"
pause
@echo off
goto Start
REM End Reinstall all built in apps

REM Start Log4j checker
:Log4j
cls
@echo off
SET MYFILE1="%~dp0scripts\log4j_detect_v0.3\log4j_scan_results.json" 
IF EXIST %MYFILE1% DEL /F %MYFILE1%
SET MYFILE2="%~dp0scripts\log4j_detect_v0.3\log4j_scan_results.log" 
IF EXIST %MYFILE2% DEL /F %MYFILE2%
powershell -ExecutionPolicy ByPass -f "%~dp0scripts\log4j_detect_v0.3\log4shell_deep_scan.ps1" -output_filepath "%~dp0scripts\log4j_detect_v0.3\log4j_scan_results.json"
pause
@echo off
goto Start
REM End of Log4j Checker

REM Start Nvidia Optimization
:nvdi
cls
@echo off
echo a. optimize on-board graphics card
echo b. optimize installed graphics card
echo 0. exit

pushd "%~dp0"

set /p choice="Enter your Choice: "
if "%choice%"=="a" goto obgc
if "%choice%"=="b" goto igc
if "%choice%"=="0" goto Start
echo Invalid choice: %choice%
echo.
pause
cls
@echo off
goto Start

REM Start OBGC Optimize
:obgc
cls
@echo off
start "Integrated Graphics Card" /d "%~dp0scripts\nvidia_inspect" cmd /k optimize_for_integrated_graphics.bat
pause
@echo off
goto Start
REM End OBGC Optimize

REM Start IGC Optimize
:igc
cls
@echo off
start "Installed Graphics Card" /d "%~dp0scripts\nvidia_inspect" cmd /k optimize_for_nvidia.bat
pause
@echo off
goto Start
REM End IGC Optimize

REM End of Nvidia Optimization
popd