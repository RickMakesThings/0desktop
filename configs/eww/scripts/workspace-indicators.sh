#!/bin/sh
bspwmWorkspaces () {

# Start Yuck output
echo -n "(box :class \"bspwm-workspaces\" :orientation \"h\" "

# Get focused workspace
focused=$(bspc query -D -d --names)
# Get occupied workspace(s)
occupied=$(bspc query -D -d .occupied --names)
# Get last workspace (needed when adding/deleting a workspace)
lastWS=$(bspc query -D --names | tail -n1)

# Fetch all current workspaces
for workspace in $(bspc query -D --names); do 
 
# Set classes, click actions focused/occupied/empty workspace(s)
if [[ $workspace == $focused ]]; then
    class=$(echo workspace-icon-focused)
    click=$(echo "while bspc node any.hidden.local.window -g hidden=off; do false; done && while bspc node 'any.!hidden.local.window' -g hidden=on; do :; done")
elif [[ $occupied == *$workspace* ]]; then
    class=$(echo workspace-icon-occupied)
    click=$(echo bspc desktop $workspace -f)
else
    class=$(echo workspace-icon-empty)
    click=$(echo bspc desktop $workspace -f)
fi

# Delete workspace, then re-number workspaces from 1-last
middleClick=$(echo "bspc desktop $workspace -r && eval bspc monitor -d $(seq -s ' ' 1 $(( --lastWS )))")
# Open right-click menu for the workspace
rightClick=$(echo $direww/scripts/rightclick.sh workspace)

# On hover of the workspace icon, display a tooltip with the names of the open windows on the workspace
tooltip=$(if [[ $(bspc query -N -d $workspace -n .window | head -n1) ]]; then eval echo -n $(wmctrl -lx | awk '$2=="'"$(( --workspace ))"'"' | cut -d '.' -f2 | cut -d ' ' -f1) | sed "s/ / | /g"; else echo -n "Empty"; fi)

# Output yuck code for each workspace
echo -n "(eventbox :class \"workspace-eventbox\" :onclick \"$click\" :onrightclick \"$ewwcmd update workspace-indicator-rightclick="$workspace" && $rightClick\" :onmiddleclick \"$middleClick\" :onscroll \"eval \$($ewwcmd get scroll-workspaces-{})\" :ondropped \"bspc node {} -d $workspace\" (box :class \"workspacebutton\" :orientation \"h\" (label :text \"$workspace\" :class \"$class\" :tooltip \"${tooltip^}\")))"

done

# Add workspace when clicking "Add workspace" button
addClick=$(echo -n "eval bspc monitor -d $(seq -s ' ' 1 $(( ++lastWS )))")
# Open right-click menu for the "Add workspace" button
rightClick=$(echo $direww/scripts/rightclick.sh addworkspace)

# Add add-workspace button & end Yuck code to send to Eww widget
echo "(eventbox :class \"workspace-eventbox\" :onclick \"$addClick\" :onrightclick \"$rightClick\" :onmiddleclick \"$addClick && bspc node @/ -d $(( ++lastWS )) && bspc desktop $lastWS -f\" :onscroll \"eval \$($ewwcmd get scroll-workspaces-{})\" :ondropped \"$addClick && bspc node -d $lastWS\" (box :class \"workspacebutton\" :orientation \"h\" (label :text \"\" :class \"add-workspace-button\" :tooltip \"Add workspace\"))))" 
}

# Execute script when called, then subscribe to bspc events to execute script again.
bspwmWorkspaces
bspc subscribe desktop_focus desktop_add desktop_remove desktop_swap node_transfer node_add node_remove | while read -r _ ; do
# desktop_rename desktop_activate
bspwmWorkspaces
done
