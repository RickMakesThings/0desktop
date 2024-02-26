#!/bin/bash

# Volume notification
function send_notification1() {
    # Get the current volume level
    volume=$(amixer get Master | tail -n1 | cut -d '[' -f2 | cut -d '%' -f1)
    # Send notification
    dunstify -a "mediaoverlay-volume" -u critical -r "9993" -h int:value:"$volume" -i "volume-$1" "Volume   ${volume}%" -t 2000
}

# Now playing notification
function send_notification2() {
    # Get now playing data
    sleep .6 &&
    artist=$(playerctl metadata artist)
    title=$(playerctl metadata title)
    img=$(playerctl metadata | grep "Url" | cut -d "/" -f3-9)
    # Send notification
    dunstify -a "mediaoverlay-nowplaying" -u critical -r "9993" "${artist}" "${title}" -i "${img}" -t 3000
}

# Include status (playing/paused)
#   status=$(playerctl status)
#   \n<i>${status}</i>

# Actions (call script as ./mediaoverlay.sh [action])
case $1 in
# Volume up
up)
    amixer set Master unmute
    amixer set Master 5%+
    send_notification1 $1
    ;;
# Volume down
down)
    amixer set Master unmute
    amixer set Master 5%-
    send_notification1 $1
    ;;
# Mute (toggle)
mute)
    amixer set Master mute
    dunstify -a "changevolume" -u low -r "9993" -h int:value:"10%" -i "volume-$1" "Volume   muted" -t 2000
    ;;
unmute)
    amixer set Master unmute
    send_notification1 $1
    ;;
# Play/Pause (toggle)
playpause)
    playerctl play-pause
    send_notification2 $1
    ;;
# Previous
prev)
    playerctl previous
    send_notification2 $1
    ;;
# Next
next)
    playerctl next
    send_notification2 $1
    ;;
esac
