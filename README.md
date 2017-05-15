Wine StarCraft 1.18.x Installer (Debian)
=======================
## What does this script do?

The installer script will download a compiled custom 32bit wine build (latest wine-staging patches applied on top of official wine source) from `http://demirkan.info/files/sc/wine-staging.tar.gz`, extract and run it to install StarCraft. As it's a 32bit build, you'll probably need to enable i386 support for your system. 

`sudo dpkg --add-architecture i386`

 It's compiled using [github.com/aveferrum/wine-staging/tree/staging-latest](https://github.com/aveferrum/wine-staging/tree/staging-latest) so if you don't want to use the precompiled binary, [just compile it yourself](https://wiki.winehq.org/Building_Wine "Building Wine").

It will create `$HOME/.wine-starcraft-ed` folder to deploy $WINEPREFIX and wine-staging binary, so no root privileges required.

## Installation
**1.** Download/clone the scripts to same folder with "StarCraft-Setup.exe" 

You can download the [StarCraft-Setup.exe here](https://battle.net/download/getInstallerForGame?version=LIVE&gameProgram=STARCRAFT "StarCraft-Setup.exe")

```
$ ls -al
-rwxr-xr-x  1 user user 3205616 May  9 16:33 StarCraft-Setup.exe
-rwxr-xr-x  1 user user    2861 May 13 15:46 wine-sc-installer.sh
-rwxr-xr-x  1 user user    1259 May 13 17:46 wine-sc-shortcuts.sh
```
**2.** Chmod the scripts as executable.

`$ chmod 755 wine-sc-installer.sh wine-sc-shortcuts.sh`

**3.** run "./wine-sc-installer"

`$ ./wine-sc-installer.sh`

**4.** If asked, install "Mono" and "Gecko" packages for the wine prefix. It's recommended to install StarCraft to a folder other than "Program Files", eg. "C:\games" and **don't launch the game** after the installation is completed. 

**5.** Once the installation is done, run `wine-sc-shortcuts.sh` to create shortcuts.

`$ ./wine-sc-shortcuts.sh`

**6.**  Now, you should have 2 new icons in your "Game" category; "StarCraft", "StarCraft WineCfg".

Using **StarCraft WineCfg**,  add **StarCraft.exe** and enable **Hide Wine version from applications** under staging tab. 
   
> Add Application -> Select Starcraft.exe -> Hide Wine version from applications -> OK
    
**7.** Run StarCraft.

## Uninstall

Just delete the hidden wine prefix folder under your $HOME path and related desktop entries.

```
$ rm -rfd $HOME/.wine-starcraft-ed 
$ rm $HOME/.local/share/applications/StarCraft.desktop
$ rm $HOME/.local/share/applications/SCWineConfig.desktop
```
