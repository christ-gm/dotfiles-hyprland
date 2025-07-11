#!/bin/bash

SELECTED_WALLPAPER=$1
WALLPAPER_DIR="$HOME/wallpapers"

if [ ! -f "$WALLPAPER_DIR/$SELECTED_WALLPAPER.jpg" ]; then
    echo -e "Error: Wallpaper '$SELECTED_WALLPAPER' not found!"
fi

#Apply pywal colors
wal -i "$WALLPAPER_DIR/$SELECTED_WALLPAPER.jpg" || { echo -e "Error: pywal failed"; exit 1; }

#Reload eww
killall eww || echo -e "Warning: No eww process found"
#eww open-many side-bar notifications
eww open bar
#Restart Hyprpaper
killall hyprpaper || echo "Warning: No hyprpaper process found"
hyprpaper &