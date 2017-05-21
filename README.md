**NOTE:** As of 05/16/2017, all required patches to run StarCraft are included to wine-staging release 2.8. If your distro provides a wine-staging 2.8 package, you're advised to install that instead. 


Wine StarCraft 1.18.x Installer (Ubuntu)
========================================

## What does this script do?

The installer script will download a 32bit wine build (latest wine-staging patches applied on top of official wine source) from `http://demirkan.info/files/sc/wine-staging.tar.xz`, extract and run it to install StarCraft. As it's a 32bit build, you'll probably need to enable i386 support for your system. 

`sudo dpkg --add-architecture i386`

 It's compiled using [github.com/aveferrum/wine-staging/tree/wine-staging-patched](https://github.com/aveferrum/wine-staging/tree/wine-staging-patched "Wine Staging Patched") so if you don't want to use the precompiled binary, [just compile it yourself](https://wiki.winehq.org/Building_Wine "Building Wine").

It will create `$HOME/.wine-starcraft-ed` folder to deploy $WINEPREFIX and wine-staging binary, so no root privileges required.

## Installation
**1.** Download/clone the script to same folder with "StarCraft-Setup.exe" 

You can download the StarCraft-Setup.exe [here](https://battle.net/download/getInstallerForGame?version=LIVE&gameProgram=STARCRAFT "StarCraft-Setup.exe")

```
$ ls -al
-rwxr-xr-x  1 user user 3205616 May  9 16:33 StarCraft-Setup.exe
-rwxr-xr-x  1 user user    2861 May 13 15:46 wine-sc-installer.sh
```
**2.** Chmod the script as executable.

`$ chmod 755 wine-sc-installer.sh`

**3.** run "./wine-sc-installer"

`$ ./wine-sc-installer.sh`

Type **1** and press **Enter** to start installation. 

**4.** If asked, install "Mono" and "Gecko" packages for the wine prefix. Following the installation, create the .desktop menu entries as described in the next step. 

**5.** Run `wine-sc-installer.sh` and select **Option 2** to create shortcuts.

**6.** Now, you should have 2 new icons in your "Game" category; "StarCraft", "StarCraft WineCfg". Simply click on **StarCraft** to run the game.

## Uninstall

Run "./wine-sc-installer" and select **Option 3**.

Script will delete the following folders & directories.

```
$ rm -rfd $HOME/.wine-starcraft-ed 
$ rm $HOME/.local/share/applications/StarCraft.desktop
$ rm $HOME/.local/share/applications/SCWineConfig.desktop
```
