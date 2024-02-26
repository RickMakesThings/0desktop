#!/bin/sh
timedateWidget () {
    # Gather info
    read -r dayshort timezone < <(date "+%a %Z")

    echo -n "(box :class \"timedate-widget\" :orientation \"v\" :space-evenly false :width \"500\"(box :orientation \"h\" :space-evenly false (literal :content analogue-clock)(box :orientation \"v\" :space-evenly false (box :orientation \"h\" :space-evenly false :class \"timedate-widget-details\" (label :halign \"start\" :text \"$timezone\" :class \"timedate-widget-details-label\")(button :class \"timedate-widget-details-copy\" :onclick \"$ewwcmd get timedate-widget-time | xclip -i -selection clipboard && dunstify -t 2000 'Current time' 'Copied to clipboard' && $dir0/scripts/eww-helper.sh clicktoclose\" '\${timedate-widget-time}')(button :class \"timedate-widget-details-app\" :halign \"end\" :onclick \"\$ewwcmd close timedate && bspc rule -a org.gnome.clocks -o layer=above sticky=on rectangle=760x350+1540+80 &&\$(gnome-clocks)\" ''))(box :orientation \"h\" :space-evenly false :class \"timedate-widget-details\" (label :halign \"start\" :text \"$dayshort\" :class \"timedate-widget-details-label\")(button :class \"timedate-widget-details-copy\" :onclick \"$ewwcmd get timedate-widget-date | xclip -i -selection clipboard && dunstify -t 2000 'Current date' 'Copied to clipboard' && $dir0/scripts/eww-helper.sh clicktoclose\" '\${timedate-widget-date}')(button :class \"timedate-widget-details-app\" :halign \"end\" :onclick \"\$ewwcmd close timedate && bspc rule -a gnome-calendar -o layer=above sticky=on rectangle=850x350+1495+80 &&\$(gnome-calendar)\" ''))))"
    echo ")"
}

timedateWidget
$ewwcmd update timedatebuttonicon="timedatebuttonicon-active"
# Monitor timedate events
while : ; do
timedateWidget
sleep 1m
done
