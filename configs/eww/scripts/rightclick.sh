#!/bin/bash
case $1 in

#==================================================
#=========== Generate dynamic jgmenus =============
#==================================================

#        # Check/set whether new windows spawn Tiled or Floating
#        if [[ $(bspc rule -l) == *"floating" ]]; then 
#        newWindows="     Tile new windows,bspc rule -r '*' && bspc rule -a '*' state=tiled,workspace-switcher"
#        else 
#        newWindows="󰗠   Tile new windows,bspc rule -r '*' && bspc rule -a '*' state=floating,pop-cosmic-workspaces"
#        fi

#        # Check/set if focus on click or hover
#        if [[ $(bspc config focus_follows_pointer) == "true" ]]; then 
#        focusPointer="󰳾     Click to focus,bspc config focus_follows_pointer false,preferences-desktop-cursors"
#        else 
#        focusPointer="     Focus on hover,bspc config focus_follows_pointer true,tool-pointer"
#        fi

#=========
# Desktop
#========
desktop )
        # Check if any windows are open
        if [[ $(bspc query -N -d -n .window) == "" ]]; then
        menuWindows=""
        else
                # Check if windows are hidden. Hide/unhide all
                if [[ $(bspc query -N -d -n .hidden.window) == "" ]]; then 
                showWindows="     Hide all windows,for window in \$(bspc query -N -d -n .!hidden.window); do bspc node \$window -g hidden; done,preferences-desktop-theme-windowdecorations"
                elif [[ $(bspc query -N -d -n .\!hidden.window) == "" ]]; then 
                showWindows="     Show all windows,while bspc node any.hidden.local.window -g hidden=off; do false; done,"
                elif [[ $(bspc query -N -d -n .hidden.window) == *""* ]] && [[ $(bspc query -N -d -n .\!hidden.window) == *""* ]]; then 
                showWindows="󰛐     Show all windows,while bspc node any.hidden.local.window -g hidden=off; do false; done, \n
                        󰛑     Hide all windows,for window in \$(bspc query -N -d -n .!hidden.window); do bspc node \$window -g hidden; done,"
                fi
        menuWindows="󰾍     Window tiling,^checkout(sub-tiling), 
                     $showWindows 
                     ^sep(), "
        fi
        
        # Check/set Eww bar
        padding=$(cat ~/.config/bspwm/bspwmrc | grep "top_padding" | cut -c '39-40')
        if [[ $(bspc config top_padding) != "0" ]]; then
        topPadding="bspc config top_padding 0"
        else
        topPadding="bspc config top_padding $padding"
        fi
        if [[ $($ewwcmd windows) == *"*bar"* && $($ewwcmd windows) == *"*backgroundbar"* ]]; then
        menuBar=",^tag(sub-bar),
                      Hide bar icons,$ewwcmd close bar,
                      Hide bar background,$ewwcmd close backgroundbar,
                 󰛑     Hide both,$topPadding && $ewwcmd close bar backgroundbar"
        elif [[ $($ewwcmd windows) == *"*bar"* && $($ewwcmd windows) != *"*backgroundbar"* ]]; then
        menuBar=",^tag(sub-bar),
                      Hide bar icons,$topPadding && $ewwcmd close bar,
                      Show bar background,$ewwcmd open backgroundbar && $ewwcmd close bar && $ewwcmd open bar,"
        elif [[ $($ewwcmd windows) != *"*bar"* && $($ewwcmd windows) == *"*backgroundbar"* ]]; then
        menuBar=",^tag(sub-bar),
                      Show bar icons,$ewwcmd open bar,
                      Hide bar background,$topPadding && $ewwcmd close backgroundbar,"
        else
        menuBar=",^tag(sub-bar),
                      Show bar icons,$topPadding && $ewwcmd open bar,
                      Show bar background,$topPadding && $ewwcmd open backgroundbar,
                 󰛐     Show both,$topPadding && $ewwcmd open-many backgroundbar bar"
        fi
        # Check/set hot corners
        if [[ $($ewwcmd windows) == *"*desktop-mouse-actions"* ]]; then
        hotCorners="󰤹     Disable hot corners,$ewwcmd close desktop-mouse-actions,"
        else
        hotCorners="      Enable hot corners,$ewwcmd open desktop-mouse-actions,"
        fi
        # Check/set if the weather overlay is visible
        if [[ $($ewwcmd get weather-overlay-class) == "desktop-weather-overlay-hidden" ]]; then 
        weatherOverlay="       Show weather overlay,$ewwcmd update weather-overlay-class='desktop-weather-overlay',"
        else 
        weatherOverlay="     Hide weather overlay,$ewwcmd update weather-overlay-class='desktop-weather-overlay-hidden',weather"
        fi
        # Check/set Monocle layout
        if [[ $(bspc query -T -d | jq -e '.layout == "monocle"') == "false" ]]; then
        monocle="󰹟   Monocle,$dir0/scripts/bspwm-helper.sh layoutMo, "
        else
        monocle="󰹟   Monocle        󰗠,bspc desktop -l tiled, "
        fi

        # Generate the jgmenu and display it
        printf "$menuWindows
                     Bar,^checkout(sub-bar),
                $hotCorners
                $weatherOverlay
                $menuBar
                ,^tag(sub-tiling),
                󱂬   Float all windows,bspc query -N -d -n .!hidden.leaf | xargs -I id bspc node id -t floating, 
                󰝘   Tile all windows,bspc query -N -d -n .!hidden.leaf | xargs -I id bspc node id -t tiled, 
                   Layout,^checkout(sub-layout), 
                ^sep(), 
                󰓦   Rotate apps,^checkout(sub-rotateapps), 
                󱍸   Rotate windows,^checkout(sub-rotatewindows), 
                ^sep(), 
                󱃧   Mirror horizontally,bspc node @/ -F vertical, 
                󱃨   Mirror verically,bspc node @/ -F horizontal, 
                ^sep(), 
                   Balance,bspc node @/ -B, 
                sub-layout,^tag(sub-rotateapps), 
                󰑧   Clockwise,bspc node @/ -C forward,
                󰑥   Counter-Clockwise,bspc node @/ -C backward,
                sub-layout,^tag(sub-rotatewindows), 
                󰑧    90  Clockwise,bspc node @/ -R 90,
                󰑥    90  Counter-Clockwise,bspc node @/ -R -90,
                   180 Clockwise,bspc node @/ -R 180,
                   180 Counter-Clockwise,bspc node @/ -R -180,
                sub-layout,^tag(sub-layout), 
                󰌪   BSPWM,$dir0/scripts/bspwm-helper.sh layoutBSPWM, 
                󱪷   Columns,$dir0/scripts/bspwm-helper.sh layoutC, 
                󱪶   Rows,$dir0/scripts/bspwm-helper.sh layoutR, 
                󰝘   Grid,dunstify Script 'Make the script dumbass', 
                󰯌   Master &amp; stack,$dir0/scripts/bspwm-helper.sh layoutMS, 
                $monocle \n" | jgmenu --simple --icon-size=0
;;



#========================
# Bar - workspace icons
#========================
workspace ) 
        # Retrieve right-clicked workspace ID, focused workspace ID, and second-last workspace ID (used when removing workspaces).
#        workspace=$(cat $direww/tmp/ws.txt)
        workspace=$($ewwcmd get workspace-indicator-rightclick)
        focused=$(bspc query -D -d --names)
        secondLastWS=$(bspc query -D --names | tail -n2 | head -n1)

        # Optionally set different menu options for empty workspaces
        if [[ $(bspc query -N -d $workspace -n .window) == "" ]]; then
        printf "^sep(Workspace $workspace) 
                ^sep() 
                󰿡     Swap with...⠀,^checkout(sub-swapworkspace),
                󰳝     Receive from ...⠀,^checkout(sub-fromworkspace), \n" > $direww/tmp/workspace-menu.csv
        else 

        # Create temporary .csv file for the jgmenu
        printf "^sep(Workspace $workspace) 
                ^sep() 
                󰿡     Swap with...⠀,^checkout(sub-swapworkspace),
                󰳟     Send all to...⠀,^checkout(sub-toworkspace), 
                󰳝     Receive from ...⠀,^checkout(sub-fromworkspace), \n" > $direww/tmp/workspace-menu.csv
        fi
        if [[ $(bspc query -N -d $workspace -n .window) == "" ]]; then
        printf "^sep(), 
                󰅙     Close workspace,bspc desktop $workspace -r && eval bspc monitor -d $(seq -s ' ' 1 $secondLastWS), 
                ,^tag(sub-swapworkspace), \n" >> $direww/tmp/workspace-menu.csv
        else
        printf "^sep(), 
                     Hide all windows,for window in \$(bspc query -N -d $workspace -n .!hidden.window); do bspc node \$window -g hidden; done,
                󰢃     Close all windows,bspc query -N -d $workspace -n .!hidden.leaf | xargs -I id bspc node id -c, 
                ^sep(), 
                󰅙     Close workspace,bspc desktop $workspace -r && eval bspc monitor -d $(seq -s ' ' 1 $secondLastWS), 
                ,^tag(sub-swapworkspace), \n" >> $direww/tmp/workspace-menu.csv
        fi

        # Generate "Swap with" menu for all current workspaces & append it to the temporary menu .csv file
        lastWS=$(bspc query -D --names | tail -n1)
        for swapws in $(bspc query -D --names); do 
        if [[ $swapws == $workspace ]]; then printf "^sep(), \n" >> $direww/tmp/workspace-menu.csv
        elif [[ $swapws == $focused ]]; then
        printf "   Workspace $swapws,bspc desktop $workspace -s $swapws && eval bspc monitor -d $(seq -s ' ' 1 $(( +lastWS ))), \n" >> $direww/tmp/workspace-menu.csv; 
        else
        printf "⠀   Workspace $swapws,bspc desktop $workspace -s $swapws && eval bspc monitor -d $(seq -s ' ' 1 $(( +lastWS ))), \n" >> $direww/tmp/workspace-menu.csv; 
        fi done

        # Generate "Send to" menu for all current workspaces & append it to the temporary menu .csv file
        printf ",^tag(sub-toworkspace), \n" >> $direww/tmp/workspace-menu.csv
        for tows in $(bspc query -D --names); do 
        if [[ $tows == $workspace ]]; then printf "^sep(), \n" >> $direww/tmp/workspace-menu.csv
        elif [[ $tows == $focused ]]; then
        printf "   Workspace $tows,bspc query -N -d $workspace -n .leaf | xargs -I id bspc node id -d $tows, \n" >> $direww/tmp/workspace-menu.csv; 
        else
        printf "⠀   Workspace $tows,bspc query -N -d $workspace -n .leaf | xargs -I id bspc node id -d $tows, \n" >> $direww/tmp/workspace-menu.csv; 
        fi done

        # Generate "Receive from" menu for all current workspaces & append it to the temporary menu .csv file
        printf ",^tag(sub-fromworkspace), \n" >> $direww/tmp/workspace-menu.csv
        for fromws in $(bspc query -D --names); do 
        if [[ $fromws == $workspace ]]; then printf "^sep(), \n" >> $direww/tmp/workspace-menu.csv
        elif [[ $fromws == $focused ]]; then
        printf "   Workspace $fromws,bspc query -N -d $fromws -n .leaf | xargs -I id bspc node id -d $workspace, \n" >> $direww/tmp/workspace-menu.csv; 
        else
        printf "⠀   Workspace $fromws,bspc query -N -d $fromws -n .leaf | xargs -I id bspc node id -d $workspace, \n" >> $direww/tmp/workspace-menu.csv; 
        fi done

        # Spawn the jgmenu
        cat $direww/tmp/workspace-menu.csv | jgmenu --simple --config-file="$dirC/jgmenu/jgmenurc-simple"
;;

#========================================
# Separate menu for add-workspace button
#========================================
addworkspace )
        lastWS=$(bspc query -D --names | tail -n1)
        addWS=$(echo "eval bspc monitor -d $(seq -s ' ' 1 $(( ++lastWS )))")
        printf "Add &amp; focus,$addWS && bspc desktop $(( ++lastWS )) -f, 
                Add &amp; send windows,$addWS && bspc query -N -d -n \.leaf | xargs -I id bspc node id -d $(( +lastWS )), 
                Add &amp; follow windows,$addWS && bspc query -N -d -n \.leaf | xargs -I id bspc node id -d $(( +lastWS )) &&  bspc desktop $(( +lastWS )) -f,
                +3  Workspaces,eval bspc monitor -d $(seq -s ' ' 1 $(($lastWS+2))),\n" | jgmenu --simple --config-file="$dirC/jgmenu/jgmenurc-simple"
;;



#====================
# Bar - window icons
#====================
window ) 

        # Set variables
        window=$($ewwcmd get window-indicator-rightclick)
        windowName=$(xdotool getwindowclassname $window)

        # Move window with mouse. Click to abort.
        move="󰁌     Move,bspc node $window -f && eval xdotool mousemove \$(expr \$(xdotool getwindowgeometry --shell $window | grep 'WIDTH' | cut -d '=' -f2) / 2 + $(xdotool getwindowgeometry --shell $window | grep 'X' | cut -d '=' -f2) &&expr \$(xdotool getwindowgeometry --shell $window | grep 'HEIGHT' | cut -d '=' -f2) / 2 + \$(xdotool getwindowgeometry --shell $window | grep 'Y' | cut -d '=' -f2)) && xdotool keydown super && xdotool mousedown 1 && sleep 1s && xdotool keyup super,"
        resize="󰲏     Resize,^checkout(sub-resize),"

        # Check if tiled. Yes: Show 'Float Window' and 'Tiling options'. No: Show 'Tile window'. Includes different Resize mode - MIDDLE CLICK TO ABORT!
        if [[ $(bspc query -N -n $window.tiled) || $(bspc query -N -n $window.pseudo_tiled) ]]; then
        state="     Float window,bspc node $window -t floating, 
        󰝘     Tiling options,^checkout(sub-tiling-options), "
        else
        state="     Tile window,bspc node $window -n last.\!automatic -t tiled & bspc node $window -t tiled,"
        fi
        # Check if window is pseudo-tiled
        if [[ $(bspc query -N -d -n .pseudo_tiled) == *"$window"* ]]; then
        pseudo="󰛺     Pseudotiled   󰗠,bspc node $window -t ~pseudo_tiled, "
        else
        pseudo="󰛺     Pseudotile,bspc node $window -t pseudo_tiled, "
        fi
        # Check if window is hidden
        if [[ $(bspc query -N -d -n .hidden) == *"$window"* ]]; then
        hidden="   Unhide                 󰗠, bspc node $window -g hidden && bspc node $window -f,"
        else
        hidden="   Hide, bspc node $window -g hidden,"
        fi
        # Check if window is locked
        if [[ $(bspc query -N -d -n .locked) == *"$window"* ]]; then
        locked="     Unlock                 󰗠, bspc node $window -g locked,"
        else
        locked="     Lock, bspc node $window -g locked,"
        fi
        # Check if window is sticky
        if [[ $(bspc query -N -d -n .sticky) == *"$window"* ]]; then
        sticky="󰹙     Unstick                󰗠, bspc node $window -g sticky,"
        else
        sticky="󰹙     Sticky, bspc node $window -g sticky,"
        fi
        # Check if window is fullscreen
        if [[ $(bspc query -N -d -n .fullscreen) == *"$window"* ]]; then
        fullscreen="󰊔     Exit fullscreen     󰗠, bspc node $window -t ~fullscreen,"
        else
        fullscreen="󰊓     Fullscreen, bspc node $window -t fullscreen,"
        fi
        # Show current layer and allow switching
        if [[ $(bspc query -N -d -n .above) == *"$window"* ]]; then
        layer="󰁝     Above          󰗠,bspc node $window -l above, 
        󱓼     Normal,bspc node $window -l normal, 
        󰁅     Below,bspc node $window -l below,"
        elif [[ $(bspc query -N -d -n .normal) == *"$window"* ]]; then
        layer="󰁝     Above,bspc node $window -l above, 
        󱓼     Normal        󰗠,bspc node $window -l normal, 
        󰁅     Below,bspc node $window -l below,"
        elif [[ $(bspc query -N -d -n .below) == *"$window"* ]]; then
        layer="󰁝     Above,bspc node $window -l above, 
        󱓼     Normal,bspc node $window -l normal, 
        󰁅     Below          󰗠,bspc node $window -l below,"
        fi
        printf "^sep($windowName) 
                ^sep() 
                $state 
                $move 
                $resize 
                󰈾     Flags,^checkout(sub-flags), 
                󰳠     Send to ...⠀,^checkout(sub-sendto), 
                ^sep(), 
                󰅙     Close,bspc node $window -c,
                ^tag(sub-tiling-options) 
                $pseudo 
                ^sep()
                     Swap with biggest,bspc node $window -s biggest.window.local, 
                󰓡     Swap with smallest,bspc node $window -s smallest.window.local, 
                ^sep()
                󰆾     Pre-select direction,^checkout(sub-presel-dir), 
                󰫙     Pre-select ratio,^checkout(sub-presel-rat), 
                󰳠     Send to pre-selection,bspc node $window -n last.\!automatic -t tiled, 
                󰜺     Cancel pre-selection,bspc node $window -p cancel, 
                ,^tag(sub-resize),
                󰁛     Top Left,bspc node $window -f && eval xdotool mousemove \$(expr $(xdotool getwindowgeometry --shell $window | grep 'X' | cut -d '=' -f2) + 50 && expr \$(xdotool getwindowgeometry --shell $window | grep 'Y' | cut -d '=' -f2) + 50) && $dir0/scripts/bspwm-helper.sh windowresize,
                󰁜     Top Right,bspc node $window -f && eval xdotool mousemove \$(expr \$(xdotool getwindowgeometry --shell $window | grep 'WIDTH' | cut -d '=' -f2) + $(xdotool getwindowgeometry --shell $window | grep 'X' | cut -d '=' -f2) - 50 && expr \$(xdotool getwindowgeometry --shell $window | grep 'Y' | cut -d '=' -f2) + 50) && $dir0/scripts/bspwm-helper.sh windowresize,
                󰁂     Bottom Left,bspc node $window -f && eval xdotool mousemove \$(expr $(xdotool getwindowgeometry --shell $window | grep 'X' | cut -d '=' -f2) + 50 && expr \$(xdotool getwindowgeometry --shell $window | grep 'HEIGHT' | cut -d '=' -f2) + \$(xdotool getwindowgeometry --shell $window | grep 'Y' | cut -d '=' -f2) - 50) && $dir0/scripts/bspwm-helper.sh windowresize,
                󰁃     Bottom Right,bspc node $window -f && eval xdotool mousemove \$(expr \$(xdotool getwindowgeometry --shell $window | grep 'WIDTH' | cut -d '=' -f2) + $(xdotool getwindowgeometry --shell $window | grep 'X' | cut -d '=' -f2) - 50 && expr \$(xdotool getwindowgeometry --shell $window | grep 'HEIGHT' | cut -d '=' -f2) + \$(xdotool getwindowgeometry --shell $window | grep 'Y' | cut -d '=' -f2) - 50) && $dir0/scripts/bspwm-helper.sh windowresize,
                ,^tag(sub-flags), 
                $hidden 
                $locked 
                $sticky 
                $fullscreen
                     Layer,^checkout(sub-layers), 
                ,^tag(sub-layers), 
                $layer 
                ,^tag(sub-presel-dir),
                󰛃     Up,bspc node $window -p north,
                󰛁     Left,bspc node $window -p west,
                󰛂     Right,bspc node $window -p east,
                󰛀     Down,bspc node $window -p south,
                ,^tag(sub-presel-rat),
                     10 %%,bspc node $window -o 0.9,
                     20 %%,bspc node $window -o 0.8,
                     30 %%,bspc node $window -o 0.7,
                     40 %%,bspc node $window -o 0.6,
                     50 %%,bspc node $window -o 0.5,
                     60 %%,bspc node $window -o 0.4,
                     70 %%,bspc node $window -o 0.3,
                     80 %%,bspc node $window -o 0.2,
                     90 %%,bspc node $window -o 0.1,
                ,^tag(sub-sendto), \n" > $direww/tmp/window-menu.csv

        currentWS=$(bspc query -D -d --names)
        for workspace in $(bspc query -D --names); do
        if [[ $currentWS == $workspace ]]; then printf "^sep(), \n" >> $direww/tmp/window-menu.csv;
        else
        printf "⠀   Workspace $workspace,bspc node $window -d $workspace, \n" >> $direww/tmp/window-menu.csv;
        fi done

        cat $direww/tmp/window-menu.csv | jgmenu --simple --config-file="$dirC/jgmenu/jgmenurc-simple"
;;

esac
