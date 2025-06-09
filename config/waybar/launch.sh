#!/bin/sh
killall waybar

if [[ $USER = "chris" ]]
then
    waybar -c ~/.config/waybar/config.jsonc & -s ~/.config/waybar/style.css
else
    waybar &
fi