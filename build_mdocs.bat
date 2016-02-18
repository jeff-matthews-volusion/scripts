@echo off
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
echo 1. Build and publish mDocs only
echo 2. Build and publish mDocs and API
::echo 3. DEBUG
::set /p choice=Enter 1 or 2 or 3: 
set /p choice=Enter 1 or 2: 
if '%choice%'=='1' goto 1. Build and publish mDocs only
if '%choice%'=='2' goto 2. Build and publish mDocs and API
::if '%choice%'=='3' goto 3. DEBUG
if '%choice%'=='' ECHO You must enter 1 or 2
echo
goto start

:1. Build and publish mDocs only
:: Changing to Flare application directory to run madbuild.exe
cd C:\Program Files (x86)\MadCap Software\MadCap Flare V11\Flare.app
:: Building the m-docs Flare project
madbuild -project C:\git\mdocs-flare-source\m-docs.flprj -target "mozu docs"
:: Deleting old files and directories from publish destination and recreating destination directory
rd C:\mdocs\flare\ /s /q
md C:\mdocs\flare\
:: Publishing output (copies local output directory to publish destination)
cd C:\mdocs\flare
xcopy C:\git\mdocs-flare-source\output\jeff_matthews\"mozu docs"\* /y /r /h /e /i
:: Running gulp
cd C:\git\mdocs
gulp
goto deploy_mdocs

:2. Build and publish both mDocs and API
:: Changing to Flare application directory to run madbuild.exe
cd C:\Program Files (x86)\MadCap Software\MadCap Flare V11\Flare.app
:: Building the m-docs Flare project
madbuild -project C:\git\mdocs-flare-source\m-docs.flprj -target "mozu docs"
:: Deleting old files and directories from publish destination and recreating destination directory
rd C:\mdocs\flare\ /s /q
md C:\mdocs\flare\
:: Publishing output (copies local output directory to publish destination)
cd C:\mdocs\flare
xcopy C:\git\mdocs-flare-source\output\jeff_matthews\"mozu docs"\* /y /r /h /e /i
:: Changing to Flare application directory to run madbuild.exe
cd C:\Program Files (x86)\MadCap Software\MadCap Flare V11\Flare.app
:: Building the API Flare project
madbuild -project C:\git\mdocs-flare-api\API_Reference.flprj -target HTML5
:: Deleting old files and directories from publish destination and recreating destination directory
rd C:\mdocs\api\ /s /q
md C:\mdocs\api\
:: Publishing output (copies local output directory to publish destination)
cd C:\mdocs\api
xcopy C:\git\mdocs-flare-api\output\jeff_matthews\HTML5\* /y /r /h /e /i
:: Running gulp
cd C:\git\mdocs
gulp

goto deploy_mdocs

::3. DEBUG
::goto deploy_mdocs

:deploy_mdocs
echo Deploy mDocs?
set /p choice=Enter Y or N: 
if '%choice%'=='Y' goto verify_branch
if '%choice%'=='N' goto N
if '%choice%'=='' goto sub_error_deploy
goto end

:N
exit 

:verify_branch
echo Which branch?
cd C:\git\Mozu.AuthContent
git branch

:sub_error_deploy
echo You must enterr N
goto deploy_mdocs

::Prompting user to specify a git branch and saving that input to the TMP system environment variable. The following IF statements look at this variable for processing the next task.
set /P _TMP=Type the name of the branch you want to deploy to and press Enter: 
if '%_TMP%'=='' goto sub_error_verify
if '%_TMP%'=='master' goto checkout_master
if '%_TMP%'=='develop' goto checkout_develop
if '%_TMP%'=='*' goto *
goto end

:sub_error_verify
echo You must specify a branch
goto verify_branch

:checkout_master
cd C:\git\Mozu.AuthContent
git checkout master
cd C:\git\mdocs
gulp deploy
goto end

:checkout_develop
cd C:\git\Mozu.AuthContent
git checkout develop
cd C:\git\mdocs
gulp deploy
goto end

:*
cd C:\git\Mozu.AuthContent
git checkout *
cd C:\git\mdocs
gulp deploy
goto end

:end
pause
exit
