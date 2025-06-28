#!/bin/bash
WINDOW_NAME="wallpaper"

if eww active-windows | grep -q "$WINDOW_NAME"; then
    eww close "$WINDOW_NAME"
else
    eww open "$WINDOW_NAME"
fi