#!/bin/bash

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# ┌─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐ #
# │                                                                                                                             │ #
# │    mmmm                                 "                 m     m        ""#    ""#                                         │ #
# │    #   "m m   m  m mm    mmm   mmmmm  mmm     mmm         #  #  #  mmm     #      #    mmmm    mmm   mmmm    mmm    m mm    │ #
# │    #    # "m m"  #"  #  "   #  # # #    #    #"  "        " #"# # "   #    #      #    #" "#  "   #  #" "#  #"  #   #"  "   │ #
# │    #    #  #m#   #   #  m"""#  # # #    #    #             ## ##" m"""#    #      #    #   #  m"""#  #   #  #""""   #       │ #
# │    #mmm"   "#    #   #  "mm"#  # # #  mm#mm  "#mm"         #   #  "mm"#    "mm    "mm  ##m#"  "mm"#  ##m#"  "#mm"   #       │ #
# │            m"                                                                          #             #                      │ #
# │           ""                                                                           "             "                      │ #
# └─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘ #       
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

# Path to the wallpaper directory
path2wp=$dir0/customisation/wallpapers

# Set a backup for when there is no connection to wttr.in
feh --bg-fill ${path2wp}/backup.png

# Start the loop that gets run every x seconds/minutes/hours (see bottom of file)
while :;
do

# Check the current system time, week, today's sunrise/sunset time, and weather
read -r location sunriseTime zenithTime sunsetTime temperature feel rain wind icon moon weatherFull < <($wttr"%l%20%S%20%z%20%s%20%t%20%f%20%p%20%w%20%c%20%m%20%C" -s)

currentTime=$(date +%s)
week=$(date +%W)
sunrise=$(date -d $sunriseTime +%s)
zenith=$(date -d $zenithTime +%s)
sunset=$(date -d $sunsetTime +%s)
weather=$(echo "$weatherFull" | cut -d ',' -f1)

$ewwcmd update weather-widget-temp="${temperature//+}" weather-widget-desc="$weatherFull" weather-widget-location="$location" weather-widget-feel="${feel//+}" weather-widget-rain="$rain" weather-widget-wind="$wind" timedate-widget-tooltip="Week ${week#0}"

# # # # # # # 
# WALLPAPER #
# # # # # # #

# Determine the current season and set night start time
    if (( ${week#0} >= 51 || ${week#0} <= 12 )); then
        season='winter'
        night=$(date -d 20:00 +%s)
    elif (( ${week#0} >= 13 && ${week#0} <= 25 )); then
        season='spring'
        night=$(date -d 21:00 +%s)
    elif (( ${week#0} >= 26 && ${week#0} <= 38 )); then
        season='summer'
        night=$(date -d 22:00 +%s)
    elif (( ${week#0} >= 39 && ${week#0} <= 50 )); then
        season='autumn'
        night=$(date -d 21:00 +%s)
    fi

# Function to set the wallpaper based on if-statements below
function setWallpaper() {
    feh --bg-fill ${path2wp}/${season}/${wallpaper}.png
}

# Determine wallpaper based on sunset/zenith/sunrise
    if (( $currentTime < $sunrise || $currentTime > $night )); then
        wallpaper='night' &&
        setWallpaper

    elif (( $currentTime >= $sunrise && $currentTime < $zenith )); then
        wallpaper='morning' &&
        setWallpaper

    elif (( $currentTime >= $zenith && $currentTime < $sunset )); then
        wallpaper='afternoon' &&
        setWallpaper

    elif (( $currentTime >= $sunset && $currentTime <= $night )); then
        wallpaper='evening' &&
        setWallpaper
    fi



# # # # # # # # # #
# WEATHER OVERLAY #
# # # # # # # # # #

# Function to set the weather overlay based on if-statements below
function setOverlay() {
    $ewwcmd update weather-overlay="empty-overlay2"
    #${season}/${wallpaper}/${overlay}"
}

# Determine icon/text/overlay based on weather
    if [[ $weather == "Sunny" || $weather == "Clear" ]]; then
        if [[ $wallpaper != "night" ]]; then
        $ewwcmd update bar-weather-icon="☀️"
        else
        $ewwcmd update bar-weather-icon="$moon"
        fi
        $ewwcmd update bar-weather-icon-tooltip="${temperature//+} 🌡 $weather"
        overlay='clear' &&
        setOverlay
    elif [[ $weather == "Partly cloudy" ]]; then
        if [[ $wallpaper != "night" ]]; then
        $ewwcmd update bar-weather-icon="⛅"
        else
        $ewwcmd update bar-weather-icon="☁️"
        fi
        $ewwcmd update bar-weather-icon-tooltip="${temperature//+} 🌡 $weather"
        overlay='cloudy' &&
        setOverlay
    elif [[ $weather == "Cloudy" || $weather == "Overcast"* ]]; then
        $ewwcmd update bar-weather-icon="☁️"
        $ewwcmd update bar-weather-icon-tooltip="${temperature//+} 🌡 $weather"
        overlay='rainy' &&
        setOverlay
    elif [[ $weather == *"thunder"* || $weather == *"Thunder"* ]]; then
        $ewwcmd update bar-weather-icon="🌩️"
        $ewwcmd update bar-weather-icon-tooltip="${temperature//+} 🌡 $weather"
        overlay='sunny' &&
        setOverlay
    elif [[ $weather == "Patchy snow possible" || $weather == "Freezing drizzle" || $weather == "Light freezing rain" || $weather == "Patchy freezing drizzle possible" ]]; then
        $ewwcmd update bar-weather-icon="🌨️"
        $ewwcmd update bar-weather-icon-tooltip="${temperature//+} 🌡 $weather"
        overlay='windy' &&
        setOverlay
    elif [[ $weather == "Blowing snow" || $weather == "Blizzard" ]]; then
        $ewwcmd update bar-weather-icon="❄️"
        $ewwcmd update bar-weather-icon-tooltip="${temperature//+} 🌡 $weather"
        overlay='rainy' &&
        setOverlay
    elif [[ $weather == "Mist" || $weather == "Fog" || $weather == "Freezing fog" ]]; then
        $ewwcmd update bar-weather-icon="🌫"
        $ewwcmd update bar-weather-icon-tooltip="${temperature//+} 🌡 $weather"
        overlay='rainy' &&
        setOverlay
    elif [[ $weather == "Patchy rain possible" || $weather == "Patchy sleet possible" || $weather == *"ight rain"* || $weather == *"ight drizzle" || $weather == "Moderate rain"* || $weather == "Shower"* ]]; then
        if [[ $wallpaper != "night" ]]; then
        $ewwcmd update bar-weather-icon="🌦"
        else
        $ewwcmd update bar-weather-icon="🌧️"
        fi
        $ewwcmd update bar-weather-icon-tooltip="${temperature//+} 🌡 $weather"
        overlay='rainy' &&
        setOverlay
    elif [[ $weather == "Heavy freezing drizzle" || $weather == "Heavy rain"* || $weather == "Drizzle"*  ]]; then
        $ewwcmd update bar-weather-icon="🌧️"
        $ewwcmd update bar-weather-icon-tooltip="${temperature//+} 🌡 $weather"
        overlay='rainy' &&
        setOverlay
    fi



# # # # # # # 
# TIME-OUT  #
# # # # # # #

# Set timeout for script (see 'sleep --help')
sleep 5m #5minutes

done
