# build_mdocs.bat
An interactive Windows CLI script that requires user input to execute properly. This script provides the following options:
  - Build and publish mDocs only (includes Gulp post-processing)
  - Build and publish mDocs and API (includes Gulp post-processing)
  - Publish merged mDocs and API output to Mozu.AuthContent repo for deployment (includes Gulp "deploy" task)
    Note: _When you select this option, the script displays a list of git branches associated with your Mozu.AuthContent repo and prompts you to enter the name of a branch to proceed._

## Using the Script

```sh
> git clone git@github.com:jeff-matthews-volusion/scripts.git
> Open build_mdocs.bat in a text editor.
> Configure all directory paths to match your local directory structure. I'm working on making this less painful.
> cd <cloned repo>
> build_mdocs.bat
```
Follow the prompts
