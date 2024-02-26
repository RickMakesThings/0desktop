#!/usr/bin/env bash

echo -en "\0active\x1f0-99\n"
echo -en "\0markup-rows\x1ftrue\n"
#echo -en "\0keep-selection\x1ffalse\n"
#echo -en "\0new-selection\x1f6\n"

# Sort by workspace
for workspace in $(bspc query -D --names); do 
# Grab all window IDs per workspace
    for window in $(bspc query -N -d $workspace -n .\!hidden.window); do
# Grab window name from window ID
        windowname=$(xdotool getwindowclassname $window | cut -d ' ' -f1 | cut -d '-' -f1)
# Manual window name overrides
        # PWAs
        if [[ $windowname == "firefox" ]]; then
            mediaWindow=$(xdotool getwindowname $window)
            if [[ $mediaWindow == *"YouTube"* ]]; then windowname="YouTube"
            elif [[ $mediaWindow == *"Twitch"* ]]; then windowname="Twitch"
            elif [[ $mediaWindow == *"TIDAL"* ]]; then windowname="Tidal"
            fi
        # Gnome
        elif [[ $windowname == *"gnome"* || $windowname == *"Gnome"* ]]; then windowname=$(xdotool getwindowname $window | cut -d '-' -f2-)
        # Libreoffice
        elif [[ $windowname == *"libreoffice"* ]]; then windowname=$(eval echo Libreoffice-$(xdotool getwindowclassname $window | cut -d '-' -f2-))
        # Flatpaks
        elif [[ $windowname == *"."* ]]; then windowname=$(xdotool getwindowname $window | rev | cut -d '.' -f1 | rev)
        fi
# Get the window description for metadata
        meta=$(xdotool getwindowname $window)
# Focused window Rofi output
        if [[ $window == $(bspc query -N -n) ]]; then
        echo -en "<b> <u>$workspace</u>    <u>${windowname^}</u></b>\0icon\x1f${windowname,,}\x1fmeta\x1f$meta focused active current\n"
# All windows Rofi output
        else
        echo -en " $workspace   ${windowname^}\0icon\x1f${windowname,,}\x1fmeta\x1f$meta\n" 
        fi
# Focused & other window actions
        if [ x"$@" = x" $workspace   ${windowname^}" ]; then
        bspc node $window -f && xdotool key Escape #--window Rofi
        elif [ x"$@" = x"<b> <u>$workspace</u>    <u>${windowname^}</u></b>" ]; then
        $dir0/scripts/bspwm-helper.sh windowhighlight
        fi
    done
# Hidden windows Rofi output
    for hidden in $(bspc query -N -d $workspace -n .hidden.window); do
        echo -en " $workspace   Hidden $hidden\0icon\x1fquickview\n" 
# Hidden window actions
        if [ x"$@" = x" $workspace   Hidden $hidden" ]; then
        bspc desktop $workspace -f && xdotool key Escape #--window Rofi
        fi
    done
done
