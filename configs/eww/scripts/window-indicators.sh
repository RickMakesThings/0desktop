#!/bin/sh
bspwmWindows () {

# Start Yuck output
echo -n "(box :orientation \"h\" :space-evenly false "

# Get focused window
focusedID=$(bspc query -N -n)
focusedName=$(xdotool getwindowclassname $focusedID)
focusedNameFull=$(eval echo \"$(xdotool getwindowname $focusedID)\")

# Fetch each open window on workspace
for window in $(bspc query -N -d -n .window); do 

# Set class and click action for focused/hidden/normal window
if [[ $focusedID == $window ]]; then
    class=$(echo window-icon-focused)
    click=$(echo bspc node $window -g hidden)
elif [[ $(bspc query -N -d -n .window.hidden) == *"$window"* ]]; then
    class=$(echo window-icon-hidden)
    click=$(echo "bspc node $window -g hidden && bspc node $window -f")
else
    class=$(echo window-icon-normal)
    click=$(echo bspc node $window -f)
fi
# Set class and click action for hidden windows


# Get the name of each window
windowName=$(xdotool getwindowclassname $window | cut -d ' ' -f1 | cut -d '-' -f1) ; 

# Manual overrides for names
# Set correct icon for Firefox PWAs
if [[ $windowName == "firefox" ]]; then
    mediaWindow=$(xdotool getwindowname $window)
    if [[ $mediaWindow == *"YouTube"* ]]; then
        windowName="YouTube"
    elif [[ $mediaWindow == *"Twitch"* ]]; then
        windowName="Twitch"
    elif [[ $mediaWindow == *"TIDAL"* ]]; then
        windowName="Tidal"
    fi
elif [[ $windowName == *"Telegram"* ]]; then
    windowName="Telegram"
# Fix gnome-name
elif [[ $windowName == *"gnome"* || $windowName == *"Gnome"* ]]; then
    windowName=$(xdotool getwindowname $window | cut -d '-' -f2-)
# Fix libreoffice-name
elif [[ $windowName == *"libreoffice"* ]]; then
    windowName=$(eval echo libreoffice*$(xdotool getwindowclassname $window | cut -d '-' -f2-))
# Fix com.Flatpak.Name 
elif [[ $windowName == *"."* ]]; then
    windowName=$(xdotool getwindowname $window | rev | cut -d '.' -f1 | rev)
fi

# Assign an icon based on the (overriden) name
# Check if icon exists
iconCheck=$(echo $dirH/.local/share/icons/Tela-circle-grey-dark/scalable/apps/*${windowName,,}*.svg 2>&1)
# Set backup when no match
if [[ $iconCheck == *"*.svg"* ]]; then
icon=$(find $dirH/.local/share/icons/Tela-circle-grey-dark/scalable/apps/applications-other.svg)
# Else use match
else icon=$(find $dirH/.local/share/icons/Tela-circle-grey-dark/scalable/apps/*${windowName,,}*.svg | tail -n 1)
fi

# Generate csv file for jgmenu (right-click)
rightClick=$(echo $direww/scripts/rightclick.sh window)

# Add exception for Eww-clicktoclose window
if [[ $(xdotool getwindowclassname $window) == "eww-clicktoclose" ]]; then :
else
# Output yuck code for each window
echo -n "(eventbox :class \"window-eventbox\" :onhover \"\${eww-soft-reset}\" :onclick \"$click\" :onrightclick \"$ewwcmd update window-indicator-rightclick="$window" && $rightClick\" :onmiddleclick \"bspc node $window -c\" :onscroll \"eval \$($ewwcmd get scroll-windows-{})\" :dragvalue '{$window}' (box :class \"windowbutton\" :orientation \"h\" (image :class \"$class\" :path \"$icon\" :image-width \"24\" :image-height \"24\" :tooltip \"${windowName^}\")))"
fi

done

# Manual overrides for names
# Set correct icon for Firefox PWAs
if [[ $focusedName == "firefox" ]]; then
    mediaWindow=$(xdotool getwindowname $focusedID)
    if [[ $mediaWindow == *"YouTube"* ]]; then focusedName="YouTube"
    elif [[ $mediaWindow == *"Twitch"* ]]; then focusedName="Twitch"
    elif [[ $mediaWindow == *"TIDAL"* ]]; then focusedName="Tidal"
    fi
elif [[ $focusedName == *"Telegram"* ]]; then focusedName="Telegram"
# Fix gnome-name
elif [[ $focusedName == *"gnome"* || $focusedName == *"Gnome"* ]]; then focusedName=$(xdotool getwindowname $focusedID | cut -d '-' -f2-)
# Fix libreoffice-name
elif [[ $focusedName == *"libreoffice"* ]]; then focusedName=$(eval echo Libreoffice $(xdotool getwindowclassname $focusedID | cut -d '-' -f2-))
# Fix com.Flatpak.Name 
elif [[ $focusedName == *"."* ]]; then focusedName=$(xdotool getwindowname $focusedID | rev | cut -d '.' -f1 | rev)
# Misc
elif [[ $focusedName == "baobab" ]]; then focusedName="Disks"
elif [[ $focusedName == "Nemo" ]]; then focusedName="Files"
elif [[ $focusedName == "obs" ]]; then focusedName="OBS Studio"
elif [[ $focusedName == "Vivaldi-stable" ]]; then focusedName="Vivaldi"
fi

# Set click action for the focused window label
click="$dir0/scripts/bspwm-helper.sh windowhighlight"


# End Yuck code to send to Eww widget
if [[ $focusedName == "" ]] || [[ $focusedName == "eww-clicktoclose" ]]; then
echo ")"
else 
echo "(eventbox :class \"window-label-eventbox\" :onhover \"$ewwcmd update window-actions=window-actions-container\" :onhoverlost \"$ewwcmd update window-actions=window-actions-container-hidden\" :onclick \"$click\" :onrightclick \"$ewwcmd update window-indicator-rightclick="$focusedID" && $rightClick\" :onmiddleclick \"bspc node $focusedID -c\" :onscroll \"eval \$($ewwcmd get scroll-windows-{})\" (box :space-evenly false :class \"windowbutton\" :orientation \"h\" (label :text \"${focusedName^}\" :limit-width \"30\" :class \"window-label\" :tooltip \"${focusedNameFull^}\")))(box :class \"\${window-actions}\" :orientation \"h\" (eventbox :class \"window-actions-eventbox\" :onhover \"$ewwcmd update window-actions=window-actions-container\" :onclick \"bspc node $focusedID -g hidden\" (box :space-evenly false :class \"windowbutton\" :orientation \"h\" (label :text \"\" :class \"window-actions-label3\" :tooltip \"Hide\")))(eventbox :class \"window-actions-eventbox\" :onhover \"$ewwcmd update window-actions=window-actions-container\" :onclick \"$dir0/scripts/bspwm-helper.sh windowmax\" (box :space-evenly false :class \"windowbutton\" :orientation \"h\" (label :text \"\" :class \"window-actions-label2\" :tooltip \"Monocle\")))(eventbox :class \"window-actions-eventbox\" :onhover \"$ewwcmd update window-actions=window-actions-container\" :onclick \"bspc node $focusedID -c\" :onrightclick \"echo "⠀  Force close,bspc node $focusedID -k," | jgmenu --simple --config-file="$dirC/jgmenu/jgmenurc-simple"\"(box :space-evenly false :class \"windowbutton\" :orientation \"h\" (label :text \"\" :class \"window-actions-label1\" :tooltip \"Close\")))))" 
fi
}

# Execute script when called, then subscribe to bspc events to execute script again.
bspwmWindows
bspc subscribe desktop_focus node_focus node_transfer node_swap node_add node_remove node_flag | while read -r _ ; do
bspwmWindows
done
