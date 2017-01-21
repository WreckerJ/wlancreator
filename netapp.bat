@echo off
color a

:start
cls
set CHOICE="   "
echo                 ******************************************
echo                 *   ~~#NETWORK APP#~~: by Quacoo boat    *
echo                 ******************************************
echo.
echo.
echo                 -new (start a hostednetwork)
echo                 -continue (continue last set hosetednetwork)
echo.
set /p CHOICE=                 I want to: 

if %CHOICE%==new goto %CHOICE%
if %CHOICE%==continue goto %CHOICE%

echo                  type either "new" or "continue"
pause
 goto start

 :new
 cls 
 cls
echo                 ******************************************
echo                 *   ~~#NETWORK APP#~~: by Quacoo boat    *  
echo                 ******************************************
echo.
echo.
echo                 Enter Require Values in Order to Setup Newtwork
set /p               SSID=SSID: 
set /p               KEY=KEY(8+ characters): 
echo.
echo ________________________________________________________________________
echo.
netsh wlan set hostednetwork mode=allow ssid=%SSID% key=%KEY%
netsh wlan start hostednetwork
echo %SSID% > text.txt
pause
goto online

:continue
netsh wlan set hostednetwork mode=allow
netsh wlan start hostednetwork
goto online


 :online
 cls
 cls
echo                 ******************************************
echo                 *   ~~#NETWORK APP#~~: by Quacoo boat    *  
echo                 ******************************************
echo.
echo.
 for /f "Delims=" %%a in (text.txt) do (
 		set TEK=%%a
 	)

echo                 your network "%TEK%" is online
echo.
echo.
echo ----------------------------------------------------------------------
echo.	
echo                 Connected clients
arp -a | findstr -i 192.168.173 | findstr /V 255 | findstr /V 192.168.173.1
echo.
echo -----------------------------------------------------------------------
echo. 
echo                type "ref" to refresh; "stop" to stop network 
set /p STATUS=                    command: 

echo.
pause
if %STATUS%==stop goto stop
goto online

:stop
netsh wlan set hostednetwork mode=disallow 
netsh wlan stop hostednetwork
goto start



