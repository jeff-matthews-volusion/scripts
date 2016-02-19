@echo off

set name=Jeff
set flareLocation=C:\Program Files (x86)\MadCap Software\MadCap Flare V11\Flare.app
set sourceLocation=C:\git\mdocs-flare-source\m-docs.flprj
set outputLocation=C:\git\mdocs-flare-source\Output\jeff_matthews\"mozu docs"
set apiSourceLocation=C:\git\mdocs-flare-api\API_Reference.flprj
set apiOutputLocation=C:\git\mdocs-flare-api\Output\jeff_matthews\HTML5
set authContentGitLocation=C:\git\Mozu.AuthContent
set authContentLocation=C:\git\Mozu.AuthContent\Mozu.AuthContent
set mdocsLocation=C:\mdocs

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

:start
echo
echo 1. Build and publish mDocs only.
echo 2. Build and publish mDocs and API.
echo 3. I'VE ALREADY BUILT MDOCS, %name%!!! Publish to my local Mozu.AuthContent repo for deployment... geez.
set /p choice=Enter 1, 2, or 3: 
if '%choice%'=='1' goto 1. build_mdocs
if '%choice%'=='2' goto 2. build_mdocs_api
if '%choice%'=='3' goto 3. deploy
if '%choice%'=='' ECHO You must enter 1, 2, or 3
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


:3. deploy
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