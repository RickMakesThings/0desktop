#!/usr/bin/env bash

#    Search
#set -u
#set -a

# Rofi config
echo -en "\0prompt\x1f\n"
#echo -en "\0message\x1fPower menu\n"
echo -en "\0markup-rows\x1ftrue\n"
echo -en "\0urgent\x1f0-10\n"
#echo -en "\0keep-selection\x1ffalse\n"



# Set static entries
echo -en "Lock\0icon\x1femblem-locked\n"
echo -en "Log out\0icon\x1fxfsm-logout\n"
echo -en "Sleep\0icon\x1fsleep\x1fmeta\x1fhibernate\n"
echo -en "Restart\0icon\x1fsystem-restart\x1fmeta\x1freboot\n"
echo -en "Power off\0icon\x1fsystem-shutdown\x1fmeta\x1fshutdown\n"

# Set static actions per option
if [ x"$@" = x"Lock" ]; then
    xsecurelock && exit 0
elif [ x"$@" = x"Log out" ]; then
    bspc quit && exit 0
elif [ x"$@" = x"Sleep" ]; then
    systemctl suspend-then-hibernate && exit 0
elif [ x"$@" = x"Restart" ]; then
    reboot
elif [ x"$@" = x"Power off" ]; then
    $ewwcmd open confirm && xdotool key Escape --window Rofi
fi
