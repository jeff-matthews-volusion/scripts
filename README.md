# build_mdocs.bat
An interactive Windows CLI script that requires user input to execute properly. This script provides the following options:
  - Build and publish mDocs only (includes Gulp post-processing)
  - Build and publish mDocs and API (includes Gulp post-processing)
  - Publish merged mDocs and API output to Mozu.AuthContent repo for deployment
    Note: _When you select this option, the script displays a list of git branches associated with your Mozu.AuthContent repo and prompts you to enter the name of a branch to proceed._

## Using the Script

```sh
> Get the latest from mdocs
> Copy build_mdocs_source.bat to the mdocs directory and rename it build_mdocs.bat (ignored by git).
> Open build_mdocs.bat in a text editor.
> Configure the variables at the top of the file to match the directory paths on your local machine.
> Save and close the file.
> Run .\build_mdocs.bat
```
Follow the prompts

Note: If you ever want to make updates to the batch file for the consumption of the rest of the group, update the file in the batch file source folder.
