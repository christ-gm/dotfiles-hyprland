# Ejemplo rápido dentro de tu script de música
URL=$(playerctl --player=ncspot metadata mpris:artUrl)
DEST="/tmp/eww_cover.png"

# Solo descargar si la URL cambió para no saturar el sistema
if [ ! -f "$DEST" ] || [ "$(cat /tmp/last_url)" != "$URL" ]; then
    curl -s "$URL" -o "$DEST"
    echo "$URL" > /tmp/last_url
fi

echo "$DEST"
