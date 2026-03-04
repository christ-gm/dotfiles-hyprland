if ls /sys/class/power_supply/ | grep -qi 'bat'; then
    echo 'true'
else
    echo 'false'
fi