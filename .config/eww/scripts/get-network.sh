CONNECTION_TYPE=$(nmcli -t -f TYPE,STATE device | awk -F ':' '$2=="connected"{print $1}')

if [[ "$CONNECTION_TYPE" == *"ethernet"* ]]; then
    ETHERNET_NAME=$(nmcli -t -f NAME connection show | grep "Wired")
    echo $ETHERNET_NAME
elif [[ "$CONNECTION_TYPE" == *"wifi"* ]]; then
    SSID=$(nmcli -t -f ACTIVE,SSID dev wifi | awk -F ':' '$1=="sí"{print $2}') #ojo cambiar esto si se tiene el locale.conf en español o ingles
    echo $SSID
else
    echo "None"
fi