#!/usr/bin/env bash

# Get the active window
activewindow=$(xdotool getactivewindow)
unset WINDOW X Y WIDTH HEIGHT SCREEN
# Get its geometry and calculate where to spawn the Rofi window
eval $(xdotool getwindowgeometry --shell "${activewindow}")
xpos=$(expr $WIDTH / 2 + $X - 350)
ypos=$(expr $HEIGHT / 2 + $Y - 320)
# Spawn the Rofi window in the center of the active window
if [[ $activewindow ]]; then
echo -en "\0theme\x1fwindow {x-offset: $xpos; y-offset: $ypos;}\n";
else
# If workspace is empty, spawn in the center of the screen
echo -en "\0theme\x1fwindow {location: 0;x-offset: 0; y-offset: 0;}\n";
fi

# Count the amount of items on the recently-used list
recents=-1
while read -r ; do
(( ++recents )) ; done < ~/.config/rofi/data/emojis-recent.txt
# Use Rofi formatting to mark these emojis as "urgent", to change their styling
recentItems=$(if [[ $recents == "-1" ]]; then echo ""; else echo "\0urgent\x1f0-$recents"; fi)

# Set additional Rofi script options
echo -en "$recentItems\n"
echo -en "\0active\x1f\n"
echo -en "\0markup-rows\x1ftrue\n"
#echo -en "\0keep-selection\x1ffalse\n"
#echo -en "\0new-selection\x1f6\n"

# Get the most recently used emoji from a file | create new entry for each file
while read -r recent; do
        echo -en "<b>$recent</b>\0icon\x1f<span font='Noto Color Emoji'>$recent</span>\n"
        # On entry accept
        if [ x"$@" = x"<b>$recent</b>" ]; then
        # Start a co-process that removes the current entry from the recently used emoji file, then re-adds it at the top, then pastes it after closing the Rofi window
        coproc emoji ( xdotool key Escape
                       sed -i /$recent/d  ~/.config/rofi/data/emojis-recent.txt  > /dev/null  2>&1
                       sed -i 1s/^/$recent\\n/ ~/.config/rofi/data/emojis-recent.txt  > /dev/null  2>&1
                       sleep .05
                       xdotool type --clearmodifiers $"$recent" )
        exit 0
        fi
done < ~/.config/rofi/data/emojis-recent.txt

# Get the emoji list from a file | create entry for each line
while read -r emoji description; do
        echo -en "$emoji\0meta\x1f$description\x1ficon\x1f<span font='Noto Color Emoji'>$emoji</span>\n"
        # On entry accept
        if [ x"$@" = x"$emoji" ]; then
        # Start a co-process that checks if the current entry is already in the recently used emojis file, and if not; add it. Then pastes it after closing the Rofi window
        coproc emoji ( xdotool key Escape
                       sed -i /$emoji/d  ~/.config/rofi/data/emojis-recent.txt  > /dev/null  2>&1
                       sed -i 1s/^/$emoji\\n/ ~/.config/rofi/data/emojis-recent.txt  > /dev/null  2>&1
                       sleep .05
                       xdotool type --clearmodifiers "$emoji" )
        exit 0
        fi
done < ~/.config/rofi/data/emojis.txt
