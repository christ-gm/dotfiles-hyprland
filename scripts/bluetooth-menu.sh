#!/bin/bash

# Opciones del menú
OPTIONS="Open Blueman\nON/OFF Bluetooth"

# Mostrar menú con wofi y capturar selección
CHOICE=$(echo -e "$OPTIONS" | wofi --show=dmenu --prompt " " --width 250 --height 100)

# Ejecutar acción según la opción elegida
case "$CHOICE" in
    "Open Blueman")
        blueman-manager
        ;;
    "ON/OFF Bluetooth")
        if [ "$(bluetoothctl show | grep 'Powered:' | awk '{print $2}')" == "yes" ]; then
            bluetoothctl power off
        else
            bluetoothctl power on
        fi
        ;;
esac