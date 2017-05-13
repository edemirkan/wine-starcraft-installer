Wine StarCraft Installer (Ubuntu)
=======================
## Installation
1. Download/clone the scripts to same folder with "StarCraft-Setup.exe" 

```
$ ls -al
-rwxr-xr-x  1 user user 3205616 May  9 16:33 StarCraft-Setup.exe
-rwxr-xr-x  1 user user    2861 May 13 15:46 wine-sc-installer.sh
-rwxr-xr-x  1 user user    1259 May 13 17:46 wine-sc-shortcuts.sh
```
2. run "./wine-sc-installer"

`	./wine-sc-installer.sh`

3. If asked, install "Mono" and "Gecko" packages for the wine prefix. It's recommended to install StarCraft to a folder other than "Program Files", eg. "C:\games" and don't launch the game after setup completes installation. 

4. Once the installation is completed, run `wine-sc-shortcuts.sh` to create shortcuts.

`	./wine-sc-shortcuts.sh`

5.  Now, you should have 2 new icons in your "Game" category; "StarCraft", "StarCraft WineCfg".

Using **StarCraft WineCfg**,  add **StarCraft.exe** and enable **Hide Wine version from applications** under staging tab. 
   
> Add Application -> Select Starcraft.exe -> Hide Wine version from applications -> OK
    
6. Run StarCraft.

## Uninstall

```
$ rm -rfd $HOME/.wine-starcraft-ed 
$ rm $HOME/.local/share/applications/StarCraft.desktop
$ rm $HOME/.local/share/applications/SCWineConfig.desktop
```