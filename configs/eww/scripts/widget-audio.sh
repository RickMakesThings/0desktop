#!/bin/sh
audioWidget () {
    # Gather hardware/settings information
    volume=$(amixer get Master | grep '%' | head -n1 | cut -d '[' -f2 | cut -d '%' -f1)
    output=$(amixer get Master | tail -n1 | cut -d "[" -f3 | cut -d "]" -f1)
    device=$(pactl get-default-sink)
    # Gather Now Playing information
    artist=$(playerctl metadata artist 2>&1)
    title=$(playerctl metadata title 2>&1)
    album=$(playerctl metadata album 2>&1)
    art=$(playerctl metadata mpris:artUrl | cut -c "8-")
    status=$(playerctl status 2>&1)
    # Show Play button if paused, show Pause button if playing
    if [[ $status == "Paused" ]]; then
        playpause=''
    else
        playpause='󰏤'
    fi

    # Use data to spawn an Eww widget
    # Output device picker
    echo -n "(box :class \"audio-widget\" :orientation \"v\" :space-evenly false (centerbox (box)(box :orientation \"v\" :space-evenly false (button :class \"audio-widget-output-device\" :halign \"center\" :valign \"start\"  :onclick \"if [[ \$($ewwcmd get audio-widget-output-list) == 'false' ]]; then \$ewwcmd update audio-widget-output-list='true'; else \$ewwcmd update audio-widget-output-list='false'; fi\" '\${audio-widget-output}  ')(revealer :reveal \"\${audio-widget-output-list}\" :transition \"slidedown\" (box :orientation \"v\" :class \"audio-widget-device-list\" "
    pactl list short sinks | while read -r id name _; do 
    # Manual naming overrides
    if [[ $name == *"usb"* ]]; then
        devicename='M-Track 2x2' #USB Audio
    elif [[ $name == *"bluez_output"* ]]; then
        devicename='Bluetooth'
    elif [[ $name == *"pci"* ]]; then
        devicename='Line out'
    else
    devicename='Generic output'
    fi
    # Don't show the currently used device in the list
    if [[ $name == $(pactl get-default-sink) ]]; then :
    else
    # For the other devices, generate a button
    echo -n "(button :onclick \"pactl set-default-sink $id & $ewwcmd update audio-widget-output='$devicename' audio-widget-output-list=false\" :class \"audio-widget-device-list-item\" '$devicename')"
    fi
    done
    # 'More options' button
    echo -n ")))(button :halign \"end\" :valign \"start\" :class \"audio-widget-more-settings\" :style \"font-size: 24px;\" :onclick \"\$ewwcmd close audio && bspc rule -a Pavucontrol -o layer=above sticky=on rectangle=530x750+3280+80 &&\$(pavucontrol)\" '' ))"

    # Volume/mute buttons and sliders (and 'more options' button)
    echo -n "(box :class \"audio-widget-sliders\" :orientation \"v\"(box :class \"\${audio-widget-volume-slider}\" :orientation \"h\" :space-evenly false (button :onclick \"amixer set Master toggle\" '\${audio-icon-volume}')(scale :min 0 :max 100 :value \"\${audio-widget-volume}\" :onchange \"amixer set Master {}%\"))(box :class \"\${audio-widget-mic-slider}\" :orientation \"h\" :space-evenly false (button :onclick \"amixer set Capture toggle \" '\${audio-widget-mic-icon}')(scale :min 0 :max 100 :value \"\${audio-widget-mic}\" :onchange \"amixer set Capture {}%\")))"
    # Now Playing 
    # Hide when no media is playing
    if [[ $artist == *"No players found"* ]]; then 
    :
    # Show compact version when there is no album art
    elif ! [[ $art ]]; then
    echo -n "(box :class \"audio-widget-info\" :orientation \"v\" :space-evenly true :style \"margin-bottom: 20px; margin-right: 20px;\"  (label :text \"$title\" :xalign 0.5 :yalign 0 :wrap false :class \"audio-widget-info-title\")(centerbox :class \"media-buttons\" :orientation \"h\" :space-evenly false (box)(box :orientation \"h\" (button :onclick \"playerctl previous\" '󰼨')(button :style \"font-size: 24px;\" :onclick \"playerctl play-pause\" '$playpause' )(button :onclick \"playerctl next\" '󰼧'))(box)))"
    else
    # Show full 'Now Playing' section with art
    echo -n "(overlay (box :orientation \"h\" :height \"220\" :width \"500\" :style \"background: url('$art') center; background-size: cover;\" :class \"audio-widget-bg-art\" )(box :class \"nowplaying\" :orientation \"h\" :space-evenly false :height \"220\" :width \"500\" (box :width \"150\" :height \"150\" :style \"background: url('$art') center; background-size: cover; min-width: 170px;\" :class \"audio-widget-art\")(centerbox :class \"audio-widget-info\" :orientation \"v\" :space-evenly false (box :space-evenly false :orientation \"v\" :valign \"start\" :height \"120\" (label :text \"$artist\" :class \"audio-widget-info-artist\" :xalign 0 :yalign 0)(label :text \"$title\" :xalign 0 :yalign 0 :wrap true :limit-width \"77\" :class \"audio-widget-info-title\")(label :text \"$album\" :xalign 0 :yalign 0 :class \"audio-widget-info-album\"))(box)(box :class \"media-buttons\" :valign \"end\" :orientation \"h\" :space-evenly false (button :onclick \"playerctl previous\" '󰼨')(button :style \"font-size: 24px;\" :onclick \"playerctl play-pause\" '$playpause' )(button :onclick \"playerctl next\" '󰼧')))))"
    fi
    echo ")"
}

audioWidget
$ewwcmd update audiobuttonicon="audiobuttonicon-active"
# Monitor audio events
{ pactl subscribe & playerctl -aF status; } | while read -r event ; do
case "$event" in
# On these events, execute audioWidget Function
 *"'change' on server"*) 
audioWidget
 ;;
 *"Playing"*) 
audioWidget
 ;;
 *"Paused"*) 
audioWidget
 ;;
 *"Stopped"*) 
audioWidget
 ;;
 esac
done
