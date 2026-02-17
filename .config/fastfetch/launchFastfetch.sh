#!/bin/bash

# Seleccionar PNG aleatorio
RANDOM_PNG=$(find "${XDG_CONFIG_HOME:-$HOME/.config}/fastfetch/pngs/" -name "*.png" 2>/dev/null | shuf -n 1)

# Si encuentra un PNG, usarlo; si no, usar un logo por defecto
if [ -n "$RANDOM_PNG" ] && [ -f "$RANDOM_PNG" ]; then
    fastfetch --logo "$RANDOM_PNG"
else
    # Fallback: usar un logo específico o none
    fastfetch --logo none
fi