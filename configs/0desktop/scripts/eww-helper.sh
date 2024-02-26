#!/bin/bash

case $1 in
# Close all possible Eww menu windows and some Gnome apps
clicktoclose)
    for closewindows in $($ewwcmd windows | grep "*"); do
    if [[ $closewindows == *"bar" ]] || [[ $closewindows == *"backgroundbar" ]] || [[ $closewindows == *"desktop" ]] || [[ $closewindows == *"desktop-mouse-actions" ]]; then : 
    else
        $ewwcmd close ${closewindows//\*}
    fi done
    $dir0/scripts/eww-helper.sh cssclasses
    $dir0/scripts/eww-helper.sh buttonstates
    killall pavucontrol gnome-weather gnome-calendar & wmctrl -c "Clocks"
;;

# Reset button states when an Eww window opens/closes
buttonstates)
    if [[ $($ewwcmd get audio-muted) == "false" ]]; then
        $ewwcmd update audiobuttonicon="audiobuttonicon"
    else
        $ewwcmd update audiobuttonicon="audiobuttonicon-muted"
    fi
    $ewwcmd update audio-widget-output-list="false" weatherbuttonicon="weatherbuttonicon" timedatebuttonicon="timedatebuttonicon"
;;

# Reset Eww CSS classes when an Eww window opens/closes
cssclasses)
    $ewwcmd update window-actions="window-actions-container-hidden" 
;;



weather-widget)
    if [[ $($ewwcmd windows | grep "*weather") ]] || [[ $(for windows in $(bspc query -N -d -n .window); do xdotool getwindowclassname $windows; done) == *"org.gnome.Weather"* ]]; then
        $dir0/scripts/eww-helper.sh clicktoclose
    else
        $dir0/scripts/eww-helper.sh clicktoclose
        $ewwcmd open-many clicktoclose weather
        $ewwcmd update weatherbuttonicon="weatherbuttonicon-active"
    fi
;;
timedate-widget)
    if [[ $($ewwcmd windows | grep "*timedate") ]] || [[ $(for windows in $(bspc query -N -d -n .window); do xdotool getwindowclassname $windows; done) == *"org.gnome.clocks"* ]] || [[ $(for windows in $(bspc query -N -d -n .window); do xdotool getwindowclassname $windows; done) == *"gnome-calendar"* ]]; then
        $dir0/scripts/eww-helper.sh clicktoclose
    else
        $dir0/scripts/eww-helper.sh clicktoclose
        $ewwcmd open-many clicktoclose timedate
        $ewwcmd update timedatebuttonicon="timedatebuttonicon-active"
    fi
;;
audio-widget)
    if [[ $($ewwcmd windows | grep "*audio") ]] || [[ $(for windows in $(bspc query -N -d -n .window); do xdotool getwindowclassname $windows; done) == *"Pavucontrol"* ]]; then
        $dir0/scripts/eww-helper.sh clicktoclose
    else
        $dir0/scripts/eww-helper.sh clicktoclose
        $ewwcmd open-many clicktoclose audio
        $ewwcmd update audiobuttonicon="audiobuttonicon-active"
    fi
;;

esac
