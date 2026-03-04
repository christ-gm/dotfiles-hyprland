calendar(){
LOCK_FILE="$HOME/.cache/eww-calendar.lock"
#EWW_BIN="$HOME/eww/target/release/eww"

run() {
    eww -c $HOME/.config/eww/ open calendar
}

# Run eww daemon if not running
if [[ ! `pidof eww` ]]; then
    eww daemon
    sleep 1
fi

# Open widgets
if [[ ! -f "$LOCK_FILE" ]]; then
    touch "$LOCK_FILE"
    run
else
    eww -c $HOME/.config/eww/ close calendar
    rm "$LOCK_FILE"
fi
}


calendar