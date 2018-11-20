**NOTE:** As of 08/17/2017, all required patches to run StarCraft are included to wine-staging release 2.14. If your distro provides a wine-staging 2.14 package, you're advised to install that instead. 


Wine StarCraft 1.20.x Installer (Ubuntu)
========================================

## What does this script do?

The installer script will install StarCraft using the winehq-staging package. As it's a 32bit build, you'll probably need to enable i386 support for your system. 

`sudo dpkg --add-architecture i386`


It will create `$HOME/.starcraft` folder to deploy $WINEPREFIX, so no root privileges required.

## Installation
**1.** Install winehq-staging

[Follow instructions here](https://wiki.winehq.org/Ubuntu)
You will need to install Staging branch

**2.** Download the "StarCraft-Setup.exe" in the same foled you have this script

You can download the StarCraft-Setup.exe [here](https://battle.net/download/getInstallerForGame?version=LIVE&gameProgram=STARCRAFT "StarCraft-Setup.exe")

```
$ ls -al
-rwxr-xr-x  1 user user 3205616 May 13 16:33 StarCraft-Setup.exe
-rwxr-xr-x  1 user user    2861 May 13 15:46 wine-sc-installer.sh
-rw-rw-r--  1 user user   13098 May 13 10:40 winecfg-icon.png
-rw-rw-r--  1 user user  125521 May 13 10:36 starcraft-icon.png
```
**3.** Chmod the script as executable.

`$ chmod 755 wine-sc-installer.sh`

**4.** run "./wine-sc-installer"

`$ ./wine-sc-installer.sh`

Type **1** and press **Enter** to start installation. 

**5.** If asked, install "Mono" and "Gecko" packages for the wine prefix. Following the installation, create the .desktop menu entries as described in the next step. 

**6.** Run `wine-sc-installer.sh` and select **Option 2** to create shortcuts.

**7.** Now, you should have 2 new icons in your "Game" category; "StarCraft", "StarCraft WineCfg". Simply click on **StarCraft** to run the game.

## Uninstall

Run "./wine-sc-installer" and select **Option 3**.

Script will delete the following folders & directories.

```
$ rm -rfd $HOME/.starcraft
$ rm $HOME/.local/share/applications/StarCraft.desktop
$ rm $HOME/.local/share/applications/SCWineConfig.desktop
```
