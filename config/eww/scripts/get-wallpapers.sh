#!/bin/bash

DIRECTORY=~/wallpapers

if [ -d $DIRECTORY ]; then
    find "$DIRECTORY" -type f \( -name "*.jpg" -o -name "*.png" \) \
        -exec basename {} \; | grep -E '^[0-9]+(\.jpg|\.png)$' | sed -E 's/\.[a-z]+$//' | jq -R 'tonumber' | jq -s .
else
    echo "[]"
    exit 1
fi