#!/usr/bin/env bash

export WINEDEBUG=-all
export WINEDLLOVERRIDES="mscoree="
export WINEPREFIX=$XDG_DATA_HOME/wine
export WINE=wine64
if [ ! -d "$WINEPREFIX" ]; then
    mkdir -p $WINEPREFIX
    wine64 wineboot
    mkdir -p "$WINEPREFIX/drive_c/Program Files (x86)/Common Files"
    mkdir -p "$WINEPREFIX/drive_c/users/$USER/AppData/Roaming/Adobe/Adobe Photoshop 2022"
    cp -r "/app/extra/Adobe" "$WINEPREFIX/drive_c/Program Files (x86)/Common Files"
    cp -r "/app/extra/Adobe Photoshop 2022 Settings" "$WINEPREFIX/drive_c/users/$USER/AppData/Roaming/Adobe/Adobe Photoshop 2022/Adobe Photoshop 2022 Settings"
    ln -s "$WINEPREFIX/drive_c/windows/regedit.exe" "$WINEPREFIX/drive_c/windows/syswow64/regedit.exe"
fi
if [ -n "$vd" ]; then
    winetricks vd="$vd"
fi
wine64 /app/extra/photoshop2022/photoshop.exe

