#!/bin/bash

echo "=== Debugging EWW Music Widget ==="
echo ""

echo "1. Checking if playerctl is installed:"
which playerctl
echo ""

echo "2. Checking if ncspot is running:"
playerctl --player=ncspot status 2>&1
echo ""

echo "3. Current music title:"
playerctl --player=ncspot metadata --format '{{ title }}' 2>&1
echo ""

echo "4. Current artist:"
playerctl --player=ncspot metadata --format '{{ artist }}' 2>&1
echo ""

echo "5. Cover art URL:"
playerctl --player=ncspot metadata --format '{{mpris:artUrl}}' 2>&1
echo ""

echo "6. All metadata:"
playerctl --player=ncspot metadata 2>&1
echo ""

echo "7. Checking placeholder image:"
ls -lh ~/.config/eww/icons/music-solid.png 2>&1
echo ""

echo "8. Testing EWW variables:"
eww -c ~/.config/eww/ get music 2>&1
echo ""
eww -c ~/.config/eww/ get artist 2>&1
echo ""
eww -c ~/.config/eww/ get current-music-cover 2>&1
echo ""
eww -c ~/.config/eww/ get current-music-seek 2>&1