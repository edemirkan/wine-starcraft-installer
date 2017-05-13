#!/bin/bash

# SET PATH VARIABLES
SC_WINE_PATH="${HOME}"/.wine-starcraft-ed
SC_WINE_INSTALL_PATH=${SC_WINE_PATH}
SC_WINE_BIN_PATH=${SC_WINE_INSTALL_PATH}/wine-staging/bin
SC_WINE_PREFIX=${SC_WINE_PATH}/sc-prefix

SC_INSTALL_DIR=$(dirname "$(find "${SC_WINE_PREFIX}"/drive_c | grep StarCraft.exe)")

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
Icon=${SC_WINE_PATH}/starcraft-icon.png
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
Icon=${SC_WINE_PATH}/winecfg-icon.png
Categories=Game;
EOF

chmod 755 "${HOME}/.local/share/applications/StarCraft.desktop"
chmod 755 "${HOME}/.local/share/applications/SCWineConfig.desktop"