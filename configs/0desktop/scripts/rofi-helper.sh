#!/bin/bash

# A simple script that allows you to launch different variations of Rofi (modi, themes).
# Link all your system GUI buttons, hotkeys, other scripts, etc to this script.
# Then you can easily swap out variations without having to go through all configs.


# Actions - Call the script like so:
# /path/to/script/launch-rofi.sh [action]
# Default location:
# ~/.config/0desktop/scripts/launch-rofi.sh startmenu
case $1 in

# Open the Rofi Start menu
startmenu)
    $dir0/scripts/eww-helper.sh clicktoclose
    rofi -show drun -modi drun,:~/.config/rofi/modes/start-win.sh,:/~/.config/rofi/modes/start-pwr.sh -theme 0start
    ;;

# Search window - Search applications, files, etc
search)
    $dir0/scripts/eww-helper.sh clicktoclose
    rofi -show run -modi run," Folders & files":~/.config/rofi/modes/search-files.sh," Internet":~/.config/rofi/modes/search-web.sh -theme 0search
    ;;


# Alt+tab menu - Shows all windows on current workspace
alttab)
    rofi -show windowcd -show-icons -theme solarized
#   rofi -show combi -modes combi -combi-modes "windowcd,window" -show-icons -theme solarized
    ;;

# Super+Alt+tab menu - Shows all open windows
superalttab)
    rofi -show window -show-icons -theme solarized
    ;;

# Clipboard history
clipboard)
    rofi -show clipboard -modi clipboard:"~/.config/rofi/modes/clipboard.sh" -theme 0clipboard
    ;;
    
# Character picker/ Emoji menu
characters)
    rofi -show 󰇵 -modi "󰇵":~/.config/rofi/modes/characters.sh,"󱔁":~/.config/rofi/modes/characters-misc.sh,"󰊪":~/.config/rofi/modes/characters-nerdfonts.sh -theme 0characters
    ;;

esac
