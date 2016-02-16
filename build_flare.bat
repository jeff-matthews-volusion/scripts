REM Getting latest version of mdocs and api from source control

cd C:\Program Files (x86)\Microsoft Visual Studio 12.0\Common7\IDE
tf get * -recursive C:\flare\trunk\m-docs
tf get * -recursive C:\flare\branches\mozu-api-mdocs\api_reference

REM Changing to Flare application directory to run madbuild.exe

cd C:\Program Files (x86)\MadCap Software\MadCap Flare V11\Flare.app

REM Building the m-docs Flare project

madbuild -project C:\flare\trunk\m-docs\m-docs.flprj -target "mozu docs"

REM Deleting old files and directories from publish destination and recreating destination directory

rd C:\mdocs\flare\ /s /q
md C:\mdocs\flare\

REM Publishing output (copies local output directory to publish destination)

cd C:\mdocs\flare
xcopy C:\flare\trunk\m-docs\output\jeff_matthews\"mozu docs"\* /y /r /h /e /i

REM Changing to Flare application directory to run madbuild.exe

cd C:\Program Files (x86)\MadCap Software\MadCap Flare V11\Flare.app

REM Building the API Flare project

madbuild -project C:\flare\branches\mozu-API-mdocs\API_Reference\API_Reference.flprj -target HTML5

REM Deleting old files and directories from publish destination and recreating destination directory

rd C:\mdocs\api\ /s /q
md C:\mdocs\api\

REM Publishing output (copies local output directory to publish destination)

cd C:\mdocs\api
xcopy C:\flare\branches\mozu-API-mdocs\API_Reference\output\jeff_matthews\HTML5\* /y /r /h /e /i

REM Running gulp

cd C:\mdocs
gulp

cd C:\