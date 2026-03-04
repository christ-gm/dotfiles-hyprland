#!/bin/bash

# Buscar la primera batería (case-insensitive)
BAT=$(ls /sys/class/power_supply 2>/dev/null | grep -i 'bat' | head -n 1)

# Si no encuentra con 'bat', intentar otros nombres comunes
if [ -z "$BAT" ]; then
    BAT=$(ls /sys/class/power_supply 2>/dev/null | grep -i 'battery' | head -n 1)
fi

# Verificar y mostrar
if [ -z "$BAT" ] || [ ! -f "/sys/class/power_supply/${BAT}/capacity" ]; then
    echo "N/A"  # Más claro que 0.0
    exit 1      # Código de error para scripts que lo checkeen
else
    cat "/sys/class/power_supply/${BAT}/capacity"
fi