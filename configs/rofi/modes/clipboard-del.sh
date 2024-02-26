#!/usr/bin/env bash

activewindow=$(xdotool getactivewindow)
unset WINDOW X Y WIDTH HEIGHT SCREENp

eval $(xdotool getwindowgeometry --shell "${activewindow}")
xpos=$(expr $WIDTH / 2 + $X - 250)
ypos=$(expr $HEIGHT / 2 + $Y - 365)
# Spawn the Rofi window in the center of the active window
if [[ $activewindow ]]; then
echo -en "\0theme\x1fwindow {x-offset: $xpos; y-offset: $ypos;} entry {placeholder-color: @red; placeholder: \"Delete entries\";} element selected.active {background-color: @red;}\n"
else
# If workspace is empty, spawn in the center of the screen
echo -en "\0theme\x1fwindow {location: 0;x-offset: 0; y-offset: 0;} entry {placeholder-color: @red; placeholder: \"Delete entries\";} element selected.active {background-color: @red;}\n"
fi

echo -en "\0active\x1f1-99\n"
echo -en "\0delim\x1f\x0f\n"

# Add option to return to the clipboard at the top
echo -en "  Back to overview\0meta\x1freturn back overview\x0f"

# Set action 
if [ x"$@" = x"  Back to overview" ]; then
        coproc backtoclipboard { sleep 0.05 && rofi -show clipboard -modi clipboard:"~/.config/rofi/modes/clipboard.sh" -theme 0clipboard && exit; }
        xdotool key Escape;
fi
# Get the clipboard history | set maximum entries | create entry for each line
gpaste-client history --oneline | head -n50 | while read -r UUID selection; do 
        echo -en "${selection:0:38}\n${selection:38:38}\n${selection:76:39}\x0f"
        if [[ x"$@" == x"${selection:0:38}"* && x*"${selection:38:38}"* ]]; then
        gpaste-client delete ${UUID%:}
        xdotool keyup Return
        coproc clipboardentrydelete { sleep 0.05 && rofi -show deleteclipboard -modi deleteclipboard:"~/.config/rofi/modes/clipboard-del.sh" -theme 0clipboard && exit; }
        xdotool key Escape;
#        xdotool key Return
        fi
done
