#!/bin/bash
# CHECK for wget & StarCraft-Setup.exe
which wget > /dev/null
if [[ $? -ne 0 ]]; 
then
    echo "ERROR: It seems 'wget' is not installed. Please install 'wget' for your GNU/Linux distro and retry."
    exit 1
fi

PWD=$(pwd)
if ! [ -f "$(pwd)"/StarCraft-Setup.exe ];
then
    echo "ERROR: Can't find 'StarCraft-Setup.exe'. Please download it from 'https://starcraft.com/en-us/' into the same folder of this script."
    exit 1
fi
# Check for required 
dpkg -l libc6:i386 libncurses5:i386 libstdc++6:i386 libxtst6:i386 libldap-2.4-2:i386 libfreetype6:i386
if [[ $? -ne 0 ]]; 
then
cat << ErrorMessage
    ERROR: One of the packages "libc6:i386, libncurses5:i386, libstdc++6:i386, libxtst6:i386, libldap-2.4-2:i386, libfreetype6:i386" couldn't be found on your system. 
    Please install them and restart installation...

    $ sudo dpkg --add-architecture i386
    $ sudo apt-get update
    $ sudo apt-get install libc6:i386 libncurses5:i386 libstdc++6:i386 libxtst6:i386 libldap-2.4-2:i386 libfreetype6:i386

ErrorMessage
    exit 1
fi


# SET PATH VARIABLES
SC_WINE_PATH=$(echo $HOME)/.wine-starcraft
SC_WINE_INSTALL_PATH=${SC_WINE_PATH}
SC_WINE_BIN_PATH=${SC_WINE_INSTALL_PATH}/wine-staging/bin
SC_WINE_PREFIX=${SC_WINE_PATH}/sc-prefix
SC_WINE_DOWNLOAD_SITE=https://www.demirkan.info/files/sc
SC_WINE_URL=${SC_WINE_DOWNLOAD_SITE}/wine-staging.tar.gz
SC_ICON_URL=${SC_WINE_DOWNLOAD_SITE}/starcraft-icon.png
SC_WINECFG_ICON_URL=${SC_WINE_DOWNLOAD_SITE}/winecfg-icon.png

if [ -d "${SC_WINE_PATH}" ];
then
    echo "Found a previous '.wine-starcraft' folder in $HOME, deleting..."
    rm -rfd "${SC_WINE_PATH}"
fi
echo "Creating bin folder for wine..."
mkdir -p "${SC_WINE_INSTALL_PATH}"

echo "Downloading wine binary..."
wget ${SC_WINE_URL} -O "${SC_WINE_INSTALL_PATH}/wine-staging.tar.gz"
wget ${SC_ICON_URL} -O "${SC_WINE_PATH}/starcraft-icon.png"
wget ${SC_WINECFG_ICON_URL} -O "${SC_WINE_PATH}/winecfg-icon.png"

echo "Extracting..."
tar -xzvf ${SC_WINE_INSTALL_PATH}/wine-staging.tar.gz --directory ${SC_WINE_INSTALL_PATH}/
echo "Deleting tarball..."
rm  ${SC_WINE_INSTALL_PATH}/wine-staging.tar.gz
echo "Wine boot..."
WINEPREFIX="${SC_WINE_PREFIX}" ${SC_WINE_BIN_PATH}/wine wineboot
echo "Wine boot completed..."

if [[ $? -ne 0 ]]; 
then
    echo "ERROR: Can't run 32bit wine. Are you using a pure 64bit system? If yes, you need to enable i386 support.
    "
    exit 1
fi

WINEPREFIX="${SC_WINE_PREFIX}" ${SC_WINE_BIN_PATH}/wine ${PWD}/StarCraft-Setup.exe | cat & pid=$!

cat << EndOfMessage
##############################################
##############################################



    :: Starting the StarCraft installer...
    :: Following the installation, DO NOT LAUNCH the GAME and run "./create-shortcuts.sh"



##############################################
##############################################
EndOfMessage

wait $pid