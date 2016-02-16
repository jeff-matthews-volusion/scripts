@echo off
cls
:start
echo
echo 1. Build and publish mDocs only
echo 2. Build and publish mDocs and API
set /p choice=Enter 1 or 2: 
if '%choice%'=='1' goto 1. Build and publish mDocs only
if '%choice%'=='2' goto 2. Build and publish mDocs and API
if '%choice%'=='' ECHO "%choice%" is not valid please try again
echo
goto start
:1. Build and publish mDocs only

REM Changing to Flare application directory to run madbuild.exe

cd C:\Program Files (x86)\MadCap Software\MadCap Flare V11\Flare.app

REM Building the m-docs Flare project

madbuild -project C:\git\mdocs-flare-source\m-docs.flprj -target "mozu docs"

REM Deleting old files and directories from publish destination and recreating destination directory

rd C:\mdocs\flare\ /s /q
md C:\mdocs\flare\

REM Publishing output (copies local output directory to publish destination)

cd C:\mdocs\flare
xcopy C:\git\mdocs-flare-source\output\jeff_matthews\"mozu docs"\* /y /r /h /e /i

REM Running gulp

cd C:\git\mdocs
gulp

goto end

:2. Build and publish both mDocs and API

REM Changing to Flare application directory to run madbuild.exe

cd C:\Program Files (x86)\MadCap Software\MadCap Flare V11\Flare.app

REM Building the m-docs Flare project

madbuild -project C:\git\mdocs-flare-source\m-docs.flprj -target "mozu docs"

REM Deleting old files and directories from publish destination and recreating destination directory

rd C:\mdocs\flare\ /s /q
md C:\mdocs\flare\

REM Publishing output (copies local output directory to publish destination)

cd C:\mdocs\flare
xcopy C:\git\mdocs-flare-source\output\jeff_matthews\"mozu docs"\* /y /r /h /e /i

REM Changing to Flare application directory to run madbuild.exe

cd C:\Program Files (x86)\MadCap Software\MadCap Flare V11\Flare.app

REM Building the API Flare project

madbuild -project C:\git\mdocs-flare-api\API_Reference.flprj -target HTML5

REM Deleting old files and directories from publish destination and recreating destination directory

rd C:\mdocs\api\ /s /q
md C:\mdocs\api\

REM Publishing output (copies local output directory to publish destination)

cd C:\mdocs\api
xcopy C:\git\mdocs-flare-api\output\jeff_matthews\HTML5\* /y /r /h /e /i

REM Running gulp

cd C:\git\mdocs
gulp

cd C:\

goto end
:end
pause
exit
