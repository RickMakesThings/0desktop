#!/usr/bin/bash

# A simple script to help Flameshot determine where the specific window you're trying to take a screenshot of is located.
# This option does not work by default with window managers like BSPWM.

# Let the user select the window and grab the ID
TMP_WINDOW_ID=$(xdotool selectwindow)
unset WINDOW X Y WIDTH HEIGHT SCREEN

# Get the window co-ordinates from eval
eval $(xdotool getwindowgeometry --shell "${TMP_WINDOW_ID}")
   
# Focus the window
bspc node -f "${TMP_WINDOW_ID}"


case $1 in

# No delay
d0)
    flameshot gui --region "${WIDTH}x${HEIGHT}+${X}+${Y}"
    ;;

# 2 Second delay
d2)
    flameshot gui -d 2500 --region "${WIDTH}x${HEIGHT}+${X}+${Y}"
    ;;

# 5 Second delay
d5)
    flameshot gui -d 5000 --region "${WIDTH}x${HEIGHT}+${X}+${Y}"
    ;;

esac
