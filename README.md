# ollama-webui-windows
A simple script to make running ollama-webgui as easy as a single command

## Installation
Just clone the repo/download the files and then run ollama.ps1. That's it.

If you want it easily accessible then just add those files to your PATH. If you do this you can start it with the 'ollama' command from any terminal

## Requirements
- Windows
    - Go to the source repositories listed in the credits for options for other operating systems. This script is Windows only.
- Docker Desktop installed
- A Nvidia GPU and up to date drivers
    - Sorry AMD fans but I don't know how to support you or if it's even possible upstream
    - I'm happy to take pull requests if someone wants to add it
 
## Credits
- [ollama-webui](https://github.com/ollama-webui/ollama-webui)
    - This project literally just invokes their docker container. They did all the hard work, check out their page for more documentation and send any UI related support their way.
- [ollama](https://github.com/jmorganca/ollama)
    - This container does all the main logic involved here. Send any model or CLI related support their way.
