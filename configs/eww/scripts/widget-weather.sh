#!/bin/sh
weatherWidget () {
    # Gather info
    temperature=$($ewwcmd get weather-widget-temp)
    rain=$($ewwcmd get weather-widget-rain)
    wind=$($ewwcmd get weather-widget-wind)


    echo -n "(box :class \"weather-widget\" :orientation \"v\" :space-evenly false :width \"500\" (box :orientation \"h\" :space-evenly false (overlay (label :text \"\${bar-weather-icon}\" :halign \"start\" :valign \"end\" :class \"weather-widget-icon\")(label :text \"${temperature//C}\" :valign \"start\" :halign \"end\" :class \"weather-widget-temp\"))(box :orientation \"v\" :space-evenly false :width \"310\" :class \"weather-widget-desc\" (label :text \"\${weather-widget-location} \" :halign \"start\" :style \"font-size: 18px; margin-right: 10px; margin-bottom: -3px;\" :class \"weather-widget-temp\")(box :orientation \"h\" :space-evenly false :style \"margin-top: 5px; margin-bottom: 15px;\" (label :text \" \${weather-widget-feel} - \" :halign \"start\" :valign \"end\")(label :text \"\${weather-widget-desc}\" :halign \"start\"))(box :orientation \"h\" :space-evenly false :class \"weather-widget-scale-wind\" (label :text \"󱗺\" :halign \"start\")(scale :min 0 :max 80 :value \"${wind//[^0-9.]/}\" :active false)(label :text \"$wind\"))(box :orientation \"h\" :space-evenly false :class \"weather-widget-scale-rain\" (label :text \"󰚐\" :halign \"start\")(scale :min 0 :max 12 :value \"${rain//mm}\" :active false)(label :text \"$rain\")))(button :halign \"end\" :valign \"start\" :class \"gnome-weather-button\" :onclick \"\$ewwcmd close weather && bspc rule -a org.gnome.Weather -o layer=above sticky=on rectangle=700x350+1570+80 &&\$(gnome-weather)\" '󰩮')) (box)"
    echo ")"
}

weatherWidget
$ewwcmd update weatherbuttonicon="weatherbuttonicon-active"
# Monitor weather events
while : ; do
weatherWidget
sleep 1m
done
