#!/usr/bin/env bash

# Get the active window
activewindow=$(xdotool getactivewindow)
unset WINDOW X Y WIDTH HEIGHT SCREEN
# Get its geometry and calculate where to spawn the Rofi window
eval $(xdotool getwindowgeometry --shell "${activewindow}")
xpos=$(expr $WIDTH / 2 + $X - 250)
ypos=$(expr $HEIGHT / 2 + $Y - 365)
# Spawn the Rofi window in the center of the active window
if [[ $activewindow ]]; then
echo -en "\0theme\x1fwindow {x-offset: $xpos; y-offset: $ypos;}\n";
else
# If workspace is empty, spawn in the center of the screen
echo -en "\0theme\x1fwindow {location: 0;x-offset: 0; y-offset: 0;}\n";
fi

# Set additional Rofi script options
#echo -en "\0markup-rows\x1ftrue\n"
echo -en "\0urgent\x1f-1\n"
echo -en "\0active\x1f-2\n"
echo -en "\0delim\x1f\x0f\n"
#echo -en "\0keep-selection\x1ffalse\n"
#echo -en "\0new-selection\x1f6\n"

# Get the clipboard history | set maximum entries | create entry for each line
gpaste-client history --oneline | head -n50 | while read -r UUID selection; do 
        echo -en "${selection:0:38}\n${selection:38:38}\n${selection:76:39}\x0f"
        if [[ x"$@" == x"${selection:0:38}"* && x*"${selection:38:38}"* ]]; then
        gpaste-client select ${UUID%:} 
        coproc paste { sleep .05 && xdotool key "ctrl+v" && exit; }
        xdotool key Escape
        fi
done

# Add option to clear the clipboard at the bottom
echo -en "  Delete entries\0meta\x1fdelete remove clipboard\x0f"
echo -en "  Clear clipboard history\0meta\x1fdelete empty sweep reset clipboard\x0f"

# Set action 
if [ x"$@" = x"  Delete entries" ]; then
        coproc clipboardentrydelete { sleep 0.05 && rofi -show deleteclipboard -modi deleteclipboard:"~/.config/rofi/modes/clipboard-del.sh" -theme 0clipboard && exit; }
        xdotool key Escape;
elif [ x"$@" = x"  Clear clipboard history" ]; then
        gpaste-client delete-history history && xdotool key Escape
fi
