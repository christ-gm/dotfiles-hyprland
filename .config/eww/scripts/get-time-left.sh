#!/bin/bash

# Obtener información de la primera batería
battery_info=$(upower -i $(upower -e | grep battery | head -n1) 2>/dev/null)

if [[ -z "$battery_info" ]]; then
    echo "No battery"
    exit 0
fi

# Extraer tiempo directamente formateado
time_display=$(echo "$battery_info" | grep -E "(time to empty|time to full)" | head -n1)

if [[ -n "$time_display" ]]; then
    # Extraer solo la parte del tiempo (ej: "2.5 hours")
    time_value=$(echo "$time_display" | sed -E 's/.*time to (empty|full):\s*//' | awk '{print $1, $2}' | xargs)
    direction=$(echo "$time_display" | grep -o "empty\|full")
    echo "$time_value to $direction"
else
    # Información alternativa - ELIMINAR ESPACIOS/TABS
    percentage=$(echo "$battery_info" | awk -F': ' '/percentage/ {print $2}' | tr -d '[:space:]')
    state=$(echo "$battery_info" | awk -F': ' '/state/ {print $2}' | xargs)
    echo "${percentage:-N/A} (${state:-unknown})"
fi