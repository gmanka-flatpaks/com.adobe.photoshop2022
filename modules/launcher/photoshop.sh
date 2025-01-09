#!/usr/bin/env bash

export WINEDEBUG=-all
export WINEDLLOVERRIDES="mscoree="
export WINEPREFIX=$XDG_DATA_HOME/wine
export WINE=wine64
if [ -d /app/extra ]; then
    export PHOTOSHOP_ROOT=/app/extra
else
    export PHOTOSHOP_ROOT=/app
fi
if [ ! -d "$WINEPREFIX" ]; then
    mkdir -p $WINEPREFIX
    wine64 wineboot
    mkdir -p "$WINEPREFIX/drive_c/Program Files (x86)/Common Files"
    mkdir -p "$WINEPREFIX/drive_c/users/$USER/AppData/Roaming/Adobe/Adobe Photoshop 2022"
    cp -r "$PHOTOSHOP_ROOT/Adobe" "$WINEPREFIX/drive_c/Program Files (x86)/Common Files"
    cp -r "$PHOTOSHOP_ROOT/Adobe Photoshop 2022 Settings" "$WINEPREFIX/drive_c/users/$USER/AppData/Roaming/Adobe/Adobe Photoshop 2022/Adobe Photoshop 2022 Settings"
    ln -s "$WINEPREFIX/drive_c/windows/regedit.exe" "$WINEPREFIX/drive_c/windows/syswow64/regedit.exe"
fi
if [ -n "$vd" ]; then
    winetricks vd="$vd"
fi
wine64 $PHOTOSHOP_ROOT/photoshop.exe

