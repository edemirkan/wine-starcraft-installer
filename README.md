Wine StarCraft Installer for Ubuntu
=======================
## Installation
1. Download/clone the scripts to same folder with "StarCraft-Setup.exe" 

```
$ ls
StarCraft-Setup.exe
wine-sc-installer.sh
wine-sc-shortcuts.sh

```
2. run "./wine-sc-installer"

`$ ./wine-sc-installer.sh`

3. If asked, install "Mono" and "Gecko" packages for the wine prefix. During the setup install StarCraft to a folder other than "Program Files", eg. "C:\games". 

4. Once the installation is completed, run `wine-sc-shortcuts.sh` to create desktop shortcuts.

`$ ./wine-sc-shortcuts.sh`

5. Follow the instructions on the terminal.
