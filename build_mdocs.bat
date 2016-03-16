@echo off

setlocal

set CONFIGSET=NO

set LOCALCONF=build_mdocs_config.bat

if "%LOCALCONF%"=="" goto config_help  
goto config_do


:config_help
echo This is a configuration help script
echo Call from another script with first parameter being the config file name
echo This script will set the variable CONFIGSET
echo   CONFIGSET=NO  in the case of error or undefined configuration
echo   CONFIGSET=YES in the case where configuration has been successfully read 
goto config_exit


:config_do
IF EXIST %LOCALCONF% goto config_cont

REM generate default setting file
echo REM configuration file> %LOCALCONF%
echo set name=Javier>> %LOCALCONF%
echo set flareLocation=C:\Program Files (x86)\MadCap Software\MadCap Flare V11\Flare.app>> %LOCALCONF%
echo set sourceLocation=C:\Users\javier_robalino\Documents\GitHub\mdocs-flare-source\m-docs.flprj>> %LOCALCONF%
echo set outputLocation=C:\Users\javier_robalino\Documents\GitHub\mdocs-flare-source\Output\javier_robalino\"mozu docs">> %LOCALCONF%
echo set apiSourceLocation=C:\Users\javier_robalino\Documents\GitHub\mdocs-flare-api\API_Reference.flprj>> %LOCALCONF%
echo set apiOutputLocation=C:\Users\javier_robalino\Documents\GitHub\mdocs-flare-api\Output\javier_robalino\HTML5>> %LOCALCONF%
echo set authContentGitLocation=C:\Users\javier_robalino\Documents\GitHub\Mozu.AuthContent>> %LOCALCONF%
echo set authContentLocation=C:\Users\javier_robalino\Documents\GitHub\Mozu.AuthContent\Mozu.AuthContent>> %LOCALCONF%
echo set mdocsLocation=C:\mdocs>> %LOCALCONF%

echo #
echo # Local configuration not yet set.
echo # A default configuration file (%LOCALCONF%) has been created.
echo # Review and edit this file, then run this batch file again.
echo #
goto config_exit


:config_cont
call %LOCALCONF%
set CONFIGSET=YES


:config_exit
if "%CONFIGSET%"=="YES" goto config_ok
echo Configuration is not set
goto exit



:exit
endlocal
exit

:config_ok
echo The following configuration is set:
echo   name=%name%
echo   flareLocation=%flareLocation%
echo   sourceLocation=%sourceLocation%
echo   outputLocation=%outputLocation%
echo   apiSourceLocation=%apiSourceLocation%
echo   apiOutputLocation=%apiOutputLocation%
echo   authContentGitLocation=%authContentGitLocation%
echo   authContentLocation=%authContentLocation%
echo   mdocsLocation=%mdocsLocation%
echo.
echo.


echo        mmmmmmm    mmmmmmm      ooooooooooo   zzzzzzzzzzzzzzzzzuuuuuu    uuuuuu  
echo      mm:::::::m  m:::::::mm  oo:::::::::::oo z:::::::::::::::zu::::u    u::::u  
echo     m::::::::::mm::::::::::mo:::::::::::::::oz::::::::::::::z u::::u    u::::u  
echo     m::::::::::::::::::::::mo:::::ooooo:::::ozzzzzzzz::::::z  u::::u    u::::u  
echo     m:::::mmm::::::mmm:::::mo::::o     o::::o      z::::::z   u::::u    u::::u  
echo     m::::m   m::::m   m::::mo::::o     o::::o     z::::::z    u::::u    u::::u  
echo     m::::m   m::::m   m::::mo::::o     o::::o    z::::::z     u::::u    u::::u  
echo     m::::m   m::::m   m::::mo::::o     o::::o   z::::::z      u:::::uuuu:::::u  
echo     m::::m   m::::m   m::::mo:::::ooooo:::::o  z::::::zzzzzzzzu:::::::::::::::uu
echo     m::::m   m::::m   m::::mo:::::::::::::::o z::::::::::::::z u:::::::::::::::u
echo     m::::m   m::::m   m::::m oo:::::::::::oo z:::::::::::::::z  uu::::::::uu:::u
echo     mmmmmm   mmmmmm   mmmmmm   ooooooooooo   zzzzzzzzzzzzzzzzz    uuuuuuuu  uuuu
echo.
echo.
echo     ****************************************************************************
echo.
echo.

:start
echo.
echo 1. Build and publish mDocs only.
echo 2. Build and publish mDocs and API.
echo 3. Build and publish beta mDocs only.
echo 4. I'VE ALREADY BUILT MDOCS, %name%!!! Publish to my local Mozu.AuthContent repo for deployment... geez.
echo 5. Exit this witchcraft. I didn't sign up for this!
set /p choice=Enter 1, 2, 3, 4, or 5: 
if '%choice%'=='1' goto 1. build_mdocs
if '%choice%'=='2' goto 2. build_mdocs_api
if '%choice%'=='3' goto 3. build_mdocs_beta
if '%choice%'=='4' goto 4. deploy
if '%choice%'=='5' exit
if '%choice%'=='' ECHO You must enter 1, 2, 3, or 4
echo
goto start

:1. build_mdocs
echo Building and publishing mDocs only
:: Changing to Flare application directory to run madbuild.exe
cd %flareLocation%
:: Building the m-docs Flare project
madbuild -project %sourceLocation% -target "mozu docs"
:: Deleting old files and directories from publish destination and recreating destination directory
rd C:\mdocs\flare\ /s /q
md C:\mdocs\flare\
:: Publishing output (copies local output directory to publish destination)
cd C:\mdocs\flare
xcopy %outputLocation%\* /y /r /h /e /i
:: Running gulp
cd %mdocsLocation%
gulp

:2. build_mdocs_api
echo Building and publishing mDocs and API
:: Changing to Flare application directory to run madbuild.exe
cd %flareLocation%
:: Building the m-docs Flare project
madbuild -project %sourceLocation% -target "mozu docs"
:: Deleting old files and directories from publish destination and recreating destination directory
rd C:\mdocs\flare\ /s /q
md C:\mdocs\flare\
:: Publishing output (copies local output directory to publish destination)
cd C:\mdocs\flare
xcopy %outputLocation%\* /y /r /h /e /i
:: Changing to Flare application directory to run madbuild.exe
cd %flareLocation%
:: Building the API Flare project
madbuild -project %apiSourceLocation% -target HTML5
:: Deleting old files and directories from publish destination and recreating destination directory
rd C:\mdocs\api\ /s /q
md C:\mdocs\api\
:: Publishing output (copies local output directory to publish destination)
cd C:\mdocs\api
xcopy %apiOutputLocation%\* /y /r /h /e /i
:: Running gulp
cd %mdocsLocation%
gulp

:3. build_mdocs_beta
echo Building and publishing mDocs only
:: Changing to Flare application directory to run madbuild.exe
cd %flareLocation%
:: Building the m-docs Flare project
madbuild -project %sourceLocation% -target "mozu docs"
:: Deleting old files and directories from publish destination and recreating destination directory
rd C:\mdocs\flare\ /s /q
md C:\mdocs\flare\
:: Publishing output (copies local output directory to publish destination)
cd C:\mdocs\flare
xcopy %outputLocation%\* /y /r /h /e /i
:: Running gulp
cd %mdocsLocation%
gulp beta


:4. deploy
echo Publishing mdocs to Mozu.AuthContent repo for deployment

:verify_branch
echo Which branch do you want to deploy?
cd %authContentGitLocation%
echo Here's a list of available git branches:
git branch

::Prompting user to specify a git branch and saving that input to the TMP system environment variable.

set /P _TMP=Type the name of the branch you want to deploy to and press Enter: 
if '%_TMP%'=='' goto sub_error_verify
cd %authContentGitLocation%
git checkout %_TMP%
::If git can't find the branch, the script stops
IF %ERRORLEVEL% NEQ 0 (
    goto verify_branch
)
cd %authContentLocation%
xcopy C:\mdocs\publish\* /y /r /h /e /i
goto end

:sub_error_verify
echo Unable to switch to specified branch. Aborting.
goto verify_branch

:end
echo AuthContent updated successfully.
exit