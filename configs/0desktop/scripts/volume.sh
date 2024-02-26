#!/bin/sh
audioInformation () {
    # Gather Now Playing information
    artist=$(playerctl metadata artist)
    title=$(playerctl metadata title)
    status=$(playerctl status)
    if [[ $status == "Paused" ]]; then
        playpause='󰏤'
    else
        playpause=''
    fi
    # Check Volume level
    volume=$(amixer get Master | tail -n1 | cut -d "[" -f2 | cut -d "%" -f1)
    # Check if muted
    output=$(amixer get Master | tail -n1 | cut -d "[" -f3 | cut -d "]" -f1)
    if [[ $output == "off" ]]; then
    icon='󰖁'
    $ewwcmd update audio-widget-volume-slider="volume-control-muted" audiobuttonicon="audiobuttonicon-muted" audio-muted="true"
    else
    $ewwcmd update audio-widget-volume-slider="volume-control" audio-muted="false"
    # Check if window is open to set the correct bar icon class
    if [[ $($ewwcmd windows | grep "*audio") ]] || [[ $(for windows in $(bspc query -N -d -n .window); do xdotool getwindowclassname $windows; done) == *"Pavucontrol"* ]]; then 
    $ewwcmd update audiobuttonicon="audiobuttonicon-active"
    else
    $ewwcmd update audiobuttonicon="audiobuttonicon"
    fi
        # Set different icons for different volume levels
        if (( $volume <= 25 )); then
            icon=''
        elif (( $volume <= 50 )); then
            icon=''
        elif (( $volume <= 75 )); then
            icon='󰕾'
        elif (( $volume <= 100 )); then
            icon=''
        fi
    fi
    # Microphone settings
    mic=$(amixer get Capture | tail -n1 | cut -d '[' -f2 | cut -d '%' -f1)
    input=$(amixer get Capture | tail -n1 | cut -d '[' -f3 | cut -d ']' -f1)
    if [[ $input == "off" ]]; then
    $ewwcmd update audio-widget-mic-icon="" audio-widget-mic="$mic" audio-widget-mic-slider="mic-control-muted"
    else
    $ewwcmd update audio-widget-mic-icon="" audio-widget-mic="$mic" audio-widget-mic-slider="mic-control"
    fi
    # Send information to Eww
    $ewwcmd update audio-widget-volume="$volume"
    $ewwcmd update audio-icon-volume="$icon"
    $ewwcmd update audio-icon-tooltip="$icon $volume  $playpause $artist - $title"

}

sleep 5
audioInformation
{ playerctl -aF status & alsactl monitor default; } | while read -r _ ; do
audioInformation
done
