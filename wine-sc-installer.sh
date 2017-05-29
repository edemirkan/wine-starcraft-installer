#!/bin/bash

# Copyright (c) 2017 Evren Demirkan

# "wine-sc-installer.sh" is free software; you can redistribute it and/or modify it under
# the terms of the GNU Lesser General Public License as published by the
# Free Software Foundation; either version 2.1 of the License, or (at
# your option) any later version.

# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.

# A copy of the GNU Lesser General Public License is included with this
# script in the file COPYING.LIB. If you did not receive this
# copy, write to the Free Software Foundation, Inc., 51 Franklin St,
# Fifth Floor, Boston, MA 02110-1301, USA.

# StarCraft® - StarCraft is a trademark or registered trademark of Blizzard Entertainment, Inc., in the U.S. and/or other countries.


# CONFIGURABLE VARIABLES
SC_WINE_PATH="${HOME}"/.wine-starcraft-ed
SC_WINE_DOWNLOAD_SITE=https://www.demirkan.info/files/sc
SC_WINE_FILE=wine-staging.tar.xz
SC_ICON=starcraft-icon.png
SC_WINECFG_ICON=winecfg-icon.png

# SETUP PATHS & URLS
SC_WINE_BIN_PATH=${SC_WINE_PATH}/wine-staging/bin
SC_WINE_DLL_PATH=${SC_WINE_PATH}/wine-staging/lib/wine/fakedlls
SC_WINE_LIB_PATH=${SC_WINE_PATH}/wine-staging/lib

SC_WINE_PREFIX=${SC_WINE_PATH}/sc-prefix
SC_WINE_URL=${SC_WINE_DOWNLOAD_SITE}/${SC_WINE_FILE}
SC_ICON_URL=${SC_WINE_DOWNLOAD_SITE}/${SC_ICON}
SC_WINECFG_ICON_URL=${SC_WINE_DOWNLOAD_SITE}/${SC_WINECFG_ICON}

install_game(){

# Check wget & StarCraft-Setup.exe..
if ! which wget > /dev/null 
then
    echo "ERROR: It seems 'wget' is not installed. Please install 'wget' for your GNU/Linux distro and retry."
    echo "Exiting..."
    exit 1
fi

PWD=$(pwd)
if ! [ -f "$(pwd)"/StarCraft-Setup.exe ];
then
    echo "ERROR: Can't find 'StarCraft-Setup.exe'. Please download it from 'https://starcraft.com/en-us/' into the same folder of this script."
    echo "Exiting..."
    exit 1
fi

# Check required packages...
if ! dpkg -l libgl1-mesa-glx:i386 libasound2:i386 libasound2-plugins:i386 libc6:i386 libncurses5:i386 libstdc++6:i386 libxtst6:i386 libldap-2.4-2:i386 libfreetype6:i386
then
cat << ErrorMessage

ERROR: Some of the packages within the list; "libgl1-mesa-glx:i386, libasound2:i386, libasound2-plugins:i386, libc6:i386, libncurses5:i386, libstdc++6:i386, libxtst6:i386, libldap-2.4-2:i386, libfreetype6:i386" could not be found installed on your system. 
Please install them and re-run the script...

$ sudo dpkg --add-architecture i386
$ sudo apt-get update
$ sudo apt-get install libgl1-mesa-glx:i386 libasound2:i386 libasound2-plugins:i386 libc6:i386 libncurses5:i386 libstdc++6:i386 libxtst6:i386 libldap-2.4-2:i386 libfreetype6:i386

Exiting...

ErrorMessage
    exit 1
fi

if [ -d "${SC_WINE_PATH}" ];
then
    echo ":: Found a previous '.wine-starcraft-ed' folder in $HOME, deleting..."
    rm -rfd "${SC_WINE_PATH}"
fi
echo ":: Creating bin folder for wine..."
mkdir -p "${SC_WINE_PATH}"

echo ":: Downloading wine binary..."
wget ${SC_WINE_URL} -O "${SC_WINE_PATH}/${SC_WINE_FILE}"
wget ${SC_ICON_URL} -O "${SC_WINE_PATH}/${SC_ICON}"
wget ${SC_WINECFG_ICON_URL} -O "${SC_WINE_PATH}/${SC_WINECFG_ICON}"

echo ":: Extracting..."
tar -Jxf "${SC_WINE_PATH}"/${SC_WINE_FILE} --directory "${SC_WINE_PATH}"/
echo ":: Deleting tarball..."
rm  "${SC_WINE_PATH}"/${SC_WINE_FILE}
echo ":: Wine boot..."

if ! WINEPREFIX="${SC_WINE_PREFIX}" "${SC_WINE_BIN_PATH}"/wine wineboot
then
    echo "ERROR: Can't run 32bit wine. Are you using a pure 64bit system? If yes, you need to enable i386 support."
    echo "Exiting..."
    exit 1
fi

export WINEDLLPATH=${SC_WINE_DLL_PATH}
export LD_LIBRARY_PATH="${SC_WINE_LIB_PATH}:$LD_LIBRARY_PATH"

WINEDEBUG=-all WINEPREFIX="${SC_WINE_PREFIX}" "${SC_WINE_BIN_PATH}"/wine "${PWD}"/StarCraft-Setup.exe | cat & pid=$!

clear
cat << EndOfMessage

:: Proceeding with Installation...

:: Once completed, please run the installer again and select '2) Create Desktop Config Files' to create the game shortcuts.

EndOfMessage

wait $pid
}


create_desktop_config_files(){

if [ ! -d "${SC_WINE_PREFIX}" ];
then
    echo "ERROR: Can't find '${SC_WINE_PREFIX}' directory. Please run '1) Install StarCraft' option first."
    echo "Exiting..."
    exit 1
fi

SC_INSTALL_DIR=$(dirname "$(find "${SC_WINE_PREFIX}"/drive_c | grep StarCraft.exe)")

if [ "${SC_INSTALL_DIR}" = "." ]; then
    echo "ERROR: Can't find StarCraft.exe in '${SC_WINE_PREFIX}'. Are you sure the game is installed properly?"
    echo "Exiting..."
    exit 1
fi

echo ":: Creating StarCraft.desktop"
#--- create StarCraft launcher in .local/share/applications ---
cat << EOF > "$HOME/.local/share/applications/StarCraft.desktop"
[Desktop Entry]
Name=StarCraft
Exec=env WINEPREFIX="${SC_WINE_PREFIX}" ${SC_WINE_BIN_PATH}/wine StarCraft.exe
Type=Application
StartupNotify=true
Comment=Play StarCraft
Path=${SC_INSTALL_DIR}
Icon=${SC_WINE_PATH}/${SC_ICON}
Categories=Game;
EOF

echo ":: Creating WineConfig.desktop"
#--- create StarCraft launcher in .local/share/applications ---
cat << EOF > "$HOME/.local/share/applications/SCWineConfig.desktop"
[Desktop Entry]
Name=StarCraft WineCfg
Exec=env WINEPREFIX="${SC_WINE_PREFIX}" ${SC_WINE_BIN_PATH}/winecfg
Type=Application
StartupNotify=true
Comment=Wine StarCraft Configuration
Icon=${SC_WINE_PATH}/${SC_WINECFG_ICON}
Categories=Game;
EOF

chmod 755 "${HOME}/.local/share/applications/StarCraft.desktop"
chmod 755 "${HOME}/.local/share/applications/SCWineConfig.desktop"
}

# Delete SC_WINE_PATH and .desktop files
uninstall_game(){
if rm -rd "${SC_WINE_PATH}"
then
    echo ":: Deleted '${SC_WINE_PATH}'" 
fi    

if rm "$HOME"/.local/share/applications/StarCraft.desktop
then
    echo ":: Deleted 'StarCraft.desktop'"
fi    
if rm "$HOME"/.local/share/applications/SCWineConfig.desktop
then
    echo ":: Deleted 'SCWineConfig.desktop'"
fi
}

# MAIN MENU  
clear
cat << Banner
################################################################
#                                                              #
#                  StarCraft Installer v0.2                    #
#                    Evren Demirkan (2017)                     #
#     https://github.com/aveferrum/wine-starcraft-installer    #           
#                                                              #
################################################################

Banner

options=("Install StarCraft" "Create Desktop Config Files"  "Remove StarCraft" "Exit")

for ((i=0; i<${#options[@]}; i++)); do 
  string="$((i+1))) ${options[$i]}"
  printf "%s\n" "$string"
done

while true; do
  echo
  read -rp 'Please type an option [1, 2, 3, 4] #? ' opt
  case $opt in
    1)
      install_game
      break
      ;;

    2)
      create_desktop_config_files
      break
      ;;

    3)
      uninstall_game
      break
      ;;

    4)
      echo "Exiting... Bye bye!"
      exit 0
      ;;
  esac
done