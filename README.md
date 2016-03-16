# build_mdocs.bat
An interactive Windows CLI script that requires user input to execute properly. This script provides the following options:
  - Build and publish mDocs only (includes Gulp post-processing)
  - Build and publish mDocs and API (includes Gulp post-processing)
  - Build and publish beta mDocs only (includes Gulp post-processing)
  - Publish merged mDocs and API output to Mozu.AuthContent repo for deployment
    Note: _When you select this option, the script displays a list of git branches associated with your Mozu.AuthContent repo and prompts you to enter the name of a branch to proceed._

## Using the Script

### First-Time Use

1. Get the latest from mdocs.
2. Run `.\build_mdocs.bat`. The batch file creates a config file and exits.
3. Open `build_mdocs_config.bat` in a text editor.
4. Configure the variables in the file to match the directory paths on your local machine.
5. Save and close the file.
6. Run `.\build_mdocs.bat` and follow the prompts.

### Subsequent Use

1. Get the latest from mdocs.
2. Run `.\build_mdocs.bat` and follow the prompts.