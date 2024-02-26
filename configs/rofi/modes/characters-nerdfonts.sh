#!/usr/bin/env bash

# Count the amount of items on the recently-used list
recents=-1
while read -r ; do
(( ++recents )) ; done < ~/.config/rofi/data/nerdfonts-recent.txt
recentItems=$(if [[ $recents == "-1" ]]; then echo ""; else echo "\0urgent\x1f0-$recents"; fi)

# Set additional Rofi script options
echo -en "$recentItems\n"
echo -en "\0markup-rows\x1ftrue\n"
echo -en "\0active\x1f\n"
#echo -en "\0keep-selection\x1ffalse\n"
#echo -en "\0new-selection\x1f6\n"

# Get the most recently used emoji from a file | create new entry for each file
while read recent; do
        echo -en "<b>$recent</b>\0icon\x1f<span color='#727272' font='RobotoMono Nerd Font Mono'>$recent</span>\n"
        # On entry accept
        if [ x"$@" = x"<b>$recent</b>" ]; then
        # Start a co-process that removes the current entry from the recently used emoji file, then re-adds it at the top, then pastes it after closing the Rofi window
        coproc nerdfont ( xdotool key Escape
                          sed -i /$recent/d  ~/.config/rofi/data/nerdfonts-recent.txt  > /dev/null  2>&1
                          sed -i "1s/^/$recent\n/" ~/.config/rofi/data/nerdfonts-recent.txt  > /dev/null  2>&1
                          sleep .05
                          xdotool type --clearmodifiers $recent )  
        exit 0
        fi
done < ~/.config/rofi/data/nerdfonts-recent.txt

# Get the emoji list from a file | create entry for each line
while read description icon; do
        echo -en "$icon\0meta\x1f${description:1}\x1ficon\x1f<span color='#727272' font='RobotoMono Nerd Font Mono'>\\$icon</span>\n"
        # On entry accept
        if [ x"$@" = x"$icon" ]; then
        # Start a co-process that checks if the current entry is already in the recently used emojis file, and if not; add it. Then pastes it after closing the Rofi window
        coproc nerdfont ( xdotool key Escape
                          eval sed -i /$(echo -en "\\$icon")/d  ~/.config/rofi/data/nerdfonts-recent.txt  > /dev/null  2>&1
                          eval sed -i "1i$(echo -en \\$icon)" ~/.config/rofi/data/nerdfonts-recent.txt  > /dev/null  2>&1
                          sleep .05
                          eval xdotool type --clearmodifiers $( echo -en "\\$icon" ))  
        exit 0
        fi
done < ~/.config/rofi/data/nerdfonts.txt
