#!/bin/bash
case $1 in

# ==========================================
# TILING LAYOUTS
# ==========================================

 # Tile windows back in
#    for window in $(bspc query -N -d -n .!hidden.window); do
#    bspc query -N -d -n .leaf | head -n1 | xargs -I id bspc node id -p east -i
#    bspc query -N -d -n .leaf | head -n1 | xargs -I id bspc node $window -n id
#    bspc node $window -t tiled;
#    bspc query -N -d -n .leaf | head -n2 | tail -n1 | xargs -I id bspc node id -p south -i
#    bspc query -N -d -n .leaf | head -n2 | tail -n1 | xargs -I id bspc node $window -n id
#    bspc node $window -t tiled;
#    done
#    for window in $(bspc query -N -d -n .!hidden.window); do
#    bspc query -N -d -n .leaf | tail -n+2 | xargs -I id bspc node id -i
#    bspc query -N -d -n .leaf | tail -n+2 | xargs -I id bspc node $window -n id
#    bspc node $window -t tiled;
#    done



#for window in $(bspc query -N -d -n .\!hidden.window); do
#    bspc query -N -d -n .leaf | head -n1 | xargs -I id bspc node id -p east -i
#    bspc query -N -d -n .leaf | head -n1 | xargs -I id bspc node $window -n id
#    bspc node $window -t tiled
#    bspc query -N -d -n .leaf | head -n2 | tail -n1 | xargs -I id bspc node id -p south -i
#    bspc query -N -d -n .leaf | head -n2 | tail -n1 | xargs -I id bspc node $window -n id
#    bspc node $window -t tiled
#    bspc query -N -d -n .leaf | tail -n+3 | xargs -I id bspc node id -i
#    bspc query -N -d -n .leaf | tail -n+3 | xargs -I id bspc node $window -n id
#    bspc node $window -t tiled
#    done


#    for window1 in $(bspc query -N -d -n .leaf.\!hidden | head -n1); do
#    bspc query -N -d -n .leaf.\!hidden | xargs -I id bspc node id -i
#    bspc query -N -d -n .leaf.\!hidden | xargs -I id bspc node id -n id
#    bspc node $window -t tiled;
#    done
#    for window in $(bspc query -N -d -n .leaf.\!hidden | tail -n+1); do
#    bspc query -N -d -n .leaf.\!hidden | xargs -I id bspc node id -i
#    bspc query -N -d -n .leaf.\!hidden | xargs -I id bspc node $window -n id
#    bspc node $window -t tiled;
#    done

layoutBSPWM )
    # Disable monocle, equalize nodes & float all windows
    bspc query -N -d -n .leaf.\!hidden | xargs -I id bspc node id -t tiled
    bspc node @/ -E
    bspc desktop -l tiled
    bspc query -N -d -n .leaf.\!hidden | xargs -I id bspc node id -t floating
    # Delete all empty leaves
    for each1 in $(bspc query -N -d -n .leaf.\!window); do bspc node $each1 -k; done
    # Tile windows back in
    for window1 in $(bspc query -N -d -n .leaf.\!hidden | sort | head -n1); do
    bspc query -N -d -n .leaf.\!hidden | sort | head -n1 | xargs -I id bspc node id -p east -i
    bspc query -N -d -n .leaf.\!hidden | sort | head -n1 | xargs -I id bspc node $window1 -n id
    bspc node $window1 -t tiled
    done 
    for window in $(bspc query -N -d -n .leaf.\!hidden | sort | tail -n+2); do
    if [[ $(bspc query -N -d -n .leaf.\!hidden | awk 'NR%2==1') == *"$window"* ]]; then
        bspc query -N -d -n .leaf.\!hidden | sort | awk 'NR%2==1' | xargs -I id bspc node id -p south -i
        bspc query -N -d -n .leaf.\!hidden | sort | awk 'NR%2==1' | xargs -I id bspc node $window -n id
    elif [[ $(bspc query -N -d -n .leaf.\!hidden | awk 'NR%2==0') == *"$window"* ]]; then
        bspc query -N -d -n .leaf.\!hidden | sort | awk 'NR%2==0' | xargs -I id bspc node id -p east -i
        bspc query -N -d -n .leaf.\!hidden | sort | awk 'NR%2==0' | xargs -I id bspc node $window -n id
    fi
    bspc node $window -t tiled
    done
    #bspc query -N -d -n .leaf.\!hidden | xargs -I id bspc node id -E -t tiled
    # Cleanup
    for each2 in $(bspc query -N -d -n .leaf.\!window); do bspc node $each2 -k; done
;;

layoutC )
    # Disable monocle
    bspc desktop -l tiled
    # Untile all windows
    bspc query -N -d -n .leaf | xargs -I id bspc node id -t floating
    # Delete all empty leaves
    for each1 in $(bspc query -N -d -n .leaf.!window); do bspc node $each1 -k; done
    # Tile windows back in
    for window in $(bspc query -N -d -n .!hidden.window); do
    bspc query -N -d -n .leaf | xargs -I id bspc node id -p east -i
    bspc query -N -d -n .leaf | xargs -I id bspc node $window -n id
    bspc node $window -t tiled; 
    done
    # Cleanup
    for each2 in $(bspc query -N -d -n .leaf.!window); do bspc node $each2 -k; done
    # Balance the layout
    bspc node @/ -B
;;

layoutR )
    # Disable monocle
    bspc desktop -l tiled
    # Untile all windows
    bspc query -N -d -n .leaf | xargs -I id bspc node id -t floating
    # Delete all empty leaves
    for each1 in $(bspc query -N -d -n .leaf.!window); do bspc node $each1 -k; done
    # Tile windows back in
    for window in $(bspc query -N -d -n .!hidden.window); do
    bspc query -N -d -n .leaf | xargs -I id bspc node id -p south -i
    bspc query -N -d -n .leaf | xargs -I id bspc node $window -n id
    bspc node $window -t tiled; 
    done
    # Cleanup
    for each2 in $(bspc query -N -d -n .leaf.!window); do bspc node $each2 -k; done
    # Balance the layout
    bspc node @/ -B
;;

layoutG )
#    # Disable monocle
#    bspc desktop -l tiled
#    # Save current settings
#    automaticScheme=()
#    scheme=$(cat $dirC/bspwm/bspwmrc | grep "automatic_scheme")
#    automaticScheme+=($scheme)
#    initialPolarity=()
#    polarity=$(cat $dirC/bspwm/bspwmrc | grep "initial_polarity")
#    initialPolarity+=($polarity)
#    splitRatio=()
#    ratio=$(cat $dirC/bspwm/bspwmrc | grep "split_ratio")
#    splitRatio+=($ratio)
#    # Set spiral config rules
#    bspc config split_ratio 0.5
#    bspc config automatic_scheme longest_side
#    bspc config initial_polarity first_child
#    # Untile all windows
#    bspc query -N -d -n .leaf | xargs -I id bspc node id -t floating
#    # Delete all empty leaves
#    for each in $(bspc query -N -d -n .leaf.!window); do bspc node $each -k; done
#    # Tile all windows
#
#    # Balance the layout
#    bspc node @/ -B;
#    # Reset settings
#    ${automaticScheme[@]}
#    ${initialPolarity[@]}
#    ${splitRatio[@]}

    # Disable monocle, equalize nodes & float all windows
    bspc desktop -l tiled
    bspc query -N -d -n .leaf.\!hidden | xargs -I id bspc node id -t tiled
    bspc node @/ -E
    bspc query -N -d -n .leaf.\!hidden | xargs -I id bspc node id -t floating
    # Delete all empty leaves
    for each1 in $(bspc query -N -d -n .leaf.\!window); do bspc node $each1 -k; done
    # Tile windows back in
    for window in $(bspc query -N -d -n .!hidden.window); do
    bspc query -N -d -n .leaf | awk 'NR%2==0' | xargs -I id bspc node id -p south -i
    bspc query -N -d -n .leaf | awk 'NR%2==0' | xargs -I id bspc node $window -n id
    bspc node $window -t tiled;
    bspc query -N -d -n .leaf | awk 'NR%2==1' | xargs -I id bspc node id -p east -i
    bspc query -N -d -n .leaf | awk 'NR%2==1' | xargs -I id bspc node $window -n id
    bspc node $window -t tiled
    done
    # Cleanup
    for each2 in $(bspc query -N -d -n .leaf.\!window); do bspc node $each2 -k; done
;;

layoutMS )
    # Disable monocle
    bspc desktop -l tiled
    # Untile all windows
    bspc query -N -d -n .leaf.\!hidden | xargs -I id bspc node id -t floating
    # Delete all empty leaves
    for each1 in $(bspc query -N -d -n .leaf.\!window); do bspc node $each1 -k; done
    # Tile windows back in
    for window1 in $(bspc query -N -d -n .\!hidden.window | head -n1); do
    bspc query -N -d -n .leaf.\!hidden | xargs -I id bspc node id -p east -o 0.7 -i
    bspc query -N -d -n .leaf.\!hidden | xargs -I id bspc node $window1 -n id
    bspc node $window1 -t tiled;
    done
    for window in $(bspc query -N -d -n .\!hidden.window | tail -n+1); do
    bspc query -N -d -n .leaf.\!hidden | tail -n+2 | xargs -I id bspc node id -p south -i
    bspc query -N -d -n .leaf.\!hidden | tail -n+2 | xargs -I id bspc node $window -n id
    bspc node $window -t tiled;
    done
    # Quickly hide the master window, balance the stack windows, and then unhide the master window.
    bspc query -N -d -n .leaf.\!hidden | head -n1 | xargs -I nd bspc node nd -g hidden
    bspc node @/ -B
    bspc query -N -d -n .leaf.hidden | tail -n1 | xargs -I nd bspc node nd -g hidden
    # Cleanup
    for each2 in $(bspc query -N -d -n .leaf.!window); do bspc node $each2 -k; done
;;

layoutMo )
    # Tile all windows
    bspc query -N -d -n .!hidden.leaf | xargs -I id bspc node id -B -t tiled
    # Delete all empty leaves
    for each1 in $(bspc query -N -d -n .leaf.!window); do bspc node $each1 -k; done
    # Enable monocle mode
    bspc desktop -l monocle
    # Cleanup
    for each2 in $(bspc query -N -d -n .leaf.!window); do bspc node $each2 -k; done
;;


# ==========================================
# WINDOW RESIZE 
# ==========================================

windowresize )
# Fixes window content update delay / screen tearing while enlarging openGL windows using bspwm resize

# Set pointer_motion_interval and release/hold down necessary keys/buttons
bspc config pointer_motion_interval 85 &
bspc config pointer_action1 resize_corner && 
xdotool keyup super && xdotool mouseup 2 && xdotool click 1 &&
xdotool keydown super && xdotool mousedown 1 && xdotool keyup super &
# Check for bspc events resize_corner or resize_side "end" 
bspc subscribe pointer_action | while read -r line; do
    if [[ "$line" == *"resize_"*"end"* ]]; then
        unset WINDOW X Y WIDTH HEIGHT SCREEN &&
        eval $(xdotool getmouselocation --shell) &&
        xdotool mousemove 0 0 &&
        xdotool mouseup 1 &&
        xdotool mousemove ${X} ${Y} &
        bspc config pointer_motion_interval 17 && bspc config pointer_action1 move &
        exit
    fi
done
;;

# ==========================================
# WINDOW MAXIMISE 
# ==========================================

windowmax )
    # Save original window state and maximise window
    if [[ $(bspc query -N -n focused.tiled) && $(bspc query -T -d | jq -e '.layout == "monocle"') == "false" ]]; then bspc desktop -l monocle && bspc node -l above && echo -n "tiled" > $dir0/tmp/winmax.txt
    elif [[ $(bspc query -N -n focused.floating) && $(bspc query -T -d | jq -e '.layout == "monocle"') == "false" ]]; then bspc node -t tiled && bspc node -l above && bspc desktop -l monocle && echo -n "floating" > $dir0/tmp/winmax.txt
        xdo
    else
        # Request original state
        state=$(cat $dir0/tmp/winmax.txt)
        # Restore windows
        if [[ $state == "tiled" && $(bspc query -T -d | jq -e '.layout == "monocle"') == "true" ]]; then
            bspc desktop -l tiled && bspc node -l normal && bspc node -f
        elif [[ $state == "floating" && $(bspc query -T -d | jq -e '.layout == "monocle"') == "true" ]]; then
            bspc desktop -l tiled && bspc node -t floating && bspc node -l normal && bspc node -f
        fi fi
;;

# ==========================================
# WINDOW HIGHLIGHT 
# ==========================================

# Workaround to be able to use the sleep command, despite the .2 second eww command time-out
windowhighlight)
$dir0/scripts/bspwm-helper.sh actualwindowhighlight
;;
# Highlight the currently active window
actualwindowhighlight )
    sleep .2
    bspc config -n focused border_width 10
    sleep .2
    bspc config -n focused border_width 0
    sleep .2
    bspc config -n focused border_width 10
    sleep .2
    bspc config -n focused border_width 0
    bspc config border_width 0 
;;

esac
