#!/bin/bash
hyprctl clients -j | jq -r '.[] | .class' | paste -sd " " -

for c in $clients; do
    case "$c" in
        "kitty") icons+=" " ;;
        "code"|"Code"|"Code - OSS") icons+="󰨞 " ;;
        "firefox") icons+=" " ;;
        *) icons+=" " ;; # icono genérico
    esac
done

echo "$icons"