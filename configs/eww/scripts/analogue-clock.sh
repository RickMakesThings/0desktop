#!/bin/sh

# Gather info
read -r year month day hour ampm minute second < <(date "+%Y %m %d %H %I %M %S")

# Convert 0-60 minutes to 0-100 graph values and create an offset for the Hour Hand of the clock
if (( $minute >= 45 )); then
minuteArm=$(echo "scale=2; ($minute * 1.667 - 25)/1" | bc)
hourOffset="+ 6"
elif (( $minute >= 30 )); then
minuteArm=$(echo "scale=2; ($minute * 1.667 - 25)/1" | bc)
hourOffset="+ 4"
elif (( $minute > 15 )); then
minuteArm=$(echo "scale=2; ($minute * 1.667 - 25)/1" | bc)
hourOffset="+ 2"
else
minuteArm=$(echo "scale=2; ($minute * 1.667 + 75)/1" | bc)
hourOffset=""
fi

# Convert 0-12 hours to 0-100 graph values
if (( ${ampm#0} >= 3 )); then
hourArm=$(echo "scale=2; ($ampm * 8.334 - 25 $hourOffset)/1" | bc)
else
hourArm=$(echo "scale=2; ($ampm * 8.334 + 75 $hourOffset)/1" | bc); fi

# Generate Yuck code to display in Eww
echo -n "(box :orientation \"h\" :space-evenly false (overlay :space-evenly false  :height \"120\" :width \"120\" (circular-progress :value \"1\" :start-at \"$minuteArm\" :thickness \"45\" :class \"analogue-clock-minutes\" :height \"90\" :width \"90\" :halign \"center\" :valign \"center\" ) (overlay :space-evenly false (circular-progress :value \"2\" :start-at \"$hourArm\" :thickness \"35\" :class \"analogue-clock-hours\" :height \"70\" :width \"70\" :halign \"center\" :valign \"center\" )(circular-progress :value \"$(echo "scale=2; $second * 1.66" | bc)\" :start-at \"75\" :thickness \"4\" :class \"analogue-clock-seconds\")))"
# End yuck code with a linebreak (no '-n' flag on the echo command)
echo ")"

# Send information to Eww for main widget to use
$ewwcmd update timedate-widget-time="$hour:$minute:$second"
$ewwcmd update timedate-widget-date="$year-$month-$day"
