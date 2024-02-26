#!/bin/bash

# =================================================================================================
# A script that automatically applies the colours set in 0desktop/customisation/colours/colours.scss
# =================================================================================================

# Works on: 
# Alacritty/bash   (terminal)
# Dunst            (notifications)
# Eww              (bar, menus, pop-ups)
# Flameshot        (screenshot utility)
# jgmenu           (right-click menus)
# Rofi             (start, window switcher, character picker)



# ==============================
# Get colours from the scss file
# ==============================

HEX_Black0=$(cat $dir0/customisation/colours/colours.scss | grep "HEX_Black0" | cut -d ' ' -f2 | cut -d ';' -f1)
HEX_Black1=$(cat $dir0/customisation/colours/colours.scss | grep "HEX_Black1" | cut -d ' ' -f2 | cut -d ';' -f1)
HEX_Black2=$(cat $dir0/customisation/colours/colours.scss | grep "HEX_Black2" | cut -d ' ' -f2 | cut -d ';' -f1)
HEX_Black3=$(cat $dir0/customisation/colours/colours.scss | grep "HEX_Black3" | cut -d ' ' -f2 | cut -d ';' -f1)
HEX_Black4=$(cat $dir0/customisation/colours/colours.scss | grep "HEX_Black4" | cut -d ' ' -f2 | cut -d ';' -f1)
HEX_Grey0=$(cat $dir0/customisation/colours/colours.scss | grep "HEX_Grey0" | cut -d ' ' -f2 | cut -d ';' -f1)
HEX_Grey1=$(cat $dir0/customisation/colours/colours.scss | grep "HEX_Grey1" | cut -d ' ' -f2 | cut -d ';' -f1)
HEX_Grey2=$(cat $dir0/customisation/colours/colours.scss | grep "HEX_Grey2" | cut -d ' ' -f2 | cut -d ';' -f1)
HEX_Grey3=$(cat $dir0/customisation/colours/colours.scss | grep "HEX_Grey3" | cut -d ' ' -f2 | cut -d ';' -f1)
HEX_Grey4=$(cat $dir0/customisation/colours/colours.scss | grep "HEX_Grey4" | cut -d ' ' -f2 | cut -d ';' -f1)
HEX_White0=$(cat $dir0/customisation/colours/colours.scss | grep "HEX_White0" | cut -d ' ' -f2 | cut -d ';' -f1)
HEX_White1=$(cat $dir0/customisation/colours/colours.scss | grep "HEX_White1" | cut -d ' ' -f2 | cut -d ';' -f1)
HEX_White2=$(cat $dir0/customisation/colours/colours.scss | grep "HEX_White2" | cut -d ' ' -f2 | cut -d ';' -f1)
HEX_White3=$(cat $dir0/customisation/colours/colours.scss | grep "HEX_White3" | cut -d ' ' -f2 | cut -d ';' -f1)
HEX_White4=$(cat $dir0/customisation/colours/colours.scss | grep "HEX_White4" | cut -d ' ' -f2 | cut -d ';' -f1)

HEX_BgWinter=$(cat $dir0/customisation/colours/colours.scss | grep "HEX_BgWinter" | cut -d ' ' -f2 | cut -d ';' -f1)
HEX_BgSpring=$(cat $dir0/customisation/colours/colours.scss | grep "HEX_BgSpring" | cut -d ' ' -f2 | cut -d ';' -f1)
HEX_BgSummer=$(cat $dir0/customisation/colours/colours.scss | grep "HEX_BgSummer" | cut -d ' ' -f2 | cut -d ';' -f1)
HEX_BgAutumn=$(cat $dir0/customisation/colours/colours.scss | grep "HEX_BgAutumn" | cut -d ' ' -f2 | cut -d ';' -f1)

HEX_Red=$(cat $dir0/customisation/colours/colours.scss | grep "HEX_Red" | cut -d ' ' -f2 | cut -d ';' -f1)
HEX_OrangeDark=$(cat $dir0/customisation/colours/colours.scss | grep "HEX_OrangeDark" | cut -d ' ' -f2 | cut -d ';' -f1)
HEX_OrangeLight=$(cat $dir0/customisation/colours/colours.scss | grep "HEX_OrangeLight" | cut -d ' ' -f2 | cut -d ';' -f1)
HEX_YellowDark=$(cat $dir0/customisation/colours/colours.scss | grep "HEX_YellowDark" | cut -d ' ' -f2 | cut -d ';' -f1)
HEX_YellowLight=$(cat $dir0/customisation/colours/colours.scss | grep "HEX_YellowLight" | cut -d ' ' -f2 | cut -d ';' -f1)
HEX_GreenDark=$(cat $dir0/customisation/colours/colours.scss | grep "HEX_GreenDark" | cut -d ' ' -f2 | cut -d ';' -f1)
HEX_GreenLight=$(cat $dir0/customisation/colours/colours.scss | grep "HEX_GreenLight" | cut -d ' ' -f2 | cut -d ';' -f1)
HEX_TealDark=$(cat $dir0/customisation/colours/colours.scss | grep "HEX_TealDark" | cut -d ' ' -f2 | cut -d ';' -f1)
HEX_TealLight=$(cat $dir0/customisation/colours/colours.scss | grep "HEX_TealLight" | cut -d ' ' -f2 | cut -d ';' -f1)
HEX_Cyan=$(cat $dir0/customisation/colours/colours.scss | grep "HEX_Cyan" | cut -d ' ' -f2 | cut -d ';' -f1)
HEX_BlueDark=$(cat $dir0/customisation/colours/colours.scss | grep "HEX_BlueDark" | cut -d ' ' -f2 | cut -d ';' -f1)
HEX_BlueLight=$(cat $dir0/customisation/colours/colours.scss | grep "HEX_BlueLight" | cut -d ' ' -f2 | cut -d ';' -f1)
HEX_PurpleDark=$(cat $dir0/customisation/colours/colours.scss | grep "HEX_PurpleDark" | cut -d ' ' -f2 | cut -d ';' -f1)
HEX_PurpleLight=$(cat $dir0/customisation/colours/colours.scss | grep "HEX_PurpleLight" | cut -d ' ' -f2 | cut -d ';' -f1)
HEX_Pink=$(cat $dir0/customisation/colours/colours.scss | grep "HEX_Pink" | cut -d ' ' -f2 | cut -d ';' -f1)



# ===============
# Dynamic colours
# ===============

# Find current colours
HEX_DBg=$(cat $dir0/customisation/colours/colours.scss | grep "HEX_DBg" | cut -d ' ' -f2 | cut -d ';' -f1)
HEX_DFg=$(cat $dir0/customisation/colours/colours.scss | grep "HEX_DFg" | cut -d ' ' -f2 | cut -d ';' -f1)
HEX_DAccent=$(cat $dir0/customisation/colours/colours.scss | grep "HEX_DAccent" | cut -d ' ' -f2 | cut -d ';' -f1)

# Determine desired colours based on season (or whatever you want)
week=$(date +%W)
if (( $week >= 51 || $week <= 12 )); then #winter
    HEX_DynamicBg=$HEX_BgWinter
    HEX_DynamicFg=$HEX_Grey4
    HEX_DynamicAccent=$HEX_Cyan
elif (( $week >= 13 && $week <= 25 )); then #spring
    HEX_DynamicBg=$HEX_BgSpring
    HEX_DynamicFg=$HEX_White2
    HEX_DynamicAccent=$HEX_TealDark
elif (( $week >= 26 && $week <= 38 )); then #summer
    HEX_DynamicBg=$HEX_BgSummer
    HEX_DynamicFg=$HEX_White2
    HEX_DynamicAccent=$HEX_YellowDark
elif (( $week >= 39 && $week <= 50 )); then #autumn
    HEX_DynamicBg=$HEX_BgAutumn
    HEX_DynamicFg=$HEX_White2
    HEX_DynamicAccent=$HEX_OrangeLight
fi

# Set these colours in the colours.scss file for Eww
echo "Setting dynamic system colours"
if [[ $HEX_DBg == $HEX_DynamicBg ]]; then :
else
    sed -i "s/_DBg: $HEX_DBg/_DBg: $HEX_DynamicBg/g" $dir0/customisation/colours/colours.scss && echo "  Dynamic Background"
fi
if [[ $HEX_DFg == $HEX_DynamicFg ]]; then :
else
    sed -i "s/_DFg: $HEX_DFg/_DFg: $HEX_DynamicFg/g" $dir0/customisation/colours/colours.scss && echo "  Dynamic Foreground"
fi
if [[ $HEX_DAccent == $HEX_DynamicAccent ]]; then :
else
    sed -i "s/_DAccent: $HEX_DAccent/_DAccent: $HEX_DynamicAccent/g" $dir0/customisation/colours/colours.scss && echo "  Dynamic Accent"
fi




# ==========================================
# Get current colours from the .config files
# ==========================================

# Alacritty
alacrittyBlack=$(cat $dirC/alacritty/alacritty.yml | grep "normal:" -A8 | grep "     black" | cut -c '16-22')
alacrittyRed=$(cat $dirC/alacritty/alacritty.yml | grep "normal:" -A8 | grep "     red" | cut -c '16-22')
alacrittyGreen=$(cat $dirC/alacritty/alacritty.yml | grep "normal:" -A8 | grep "     green" | cut -c '16-22')
alacrittyYellow=$(cat $dirC/alacritty/alacritty.yml | grep "normal:" -A8 | grep "     yellow" | cut -c '16-22')
alacrittyBlue=$(cat $dirC/alacritty/alacritty.yml | grep "normal:" -A8 | grep "     blue" | cut -c '16-22')
alacrittyMagenta=$(cat $dirC/alacritty/alacritty.yml | grep "normal:" -A8 | grep "     magenta" | cut -c '16-22')
alacrittyCyan=$(cat $dirC/alacritty/alacritty.yml | grep "normal:" -A8 | grep "     cyan" | cut -c '16-22')
alacrittyWhite=$(cat $dirC/alacritty/alacritty.yml | grep "normal:" -A8 | grep "     white" | cut -c '16-22')

# Dunst
dunstLowBg=$(cat $dirC/dunst/dunstrc | grep "urgency_low" -A4 | grep "background" | cut -c '19-25')
dunstLowFg=$(cat $dirC/dunst/dunstrc | grep "urgency_low" -A4 | grep "foreground" | cut -c '19-25')
dunstLowFrame=$(cat $dirC/dunst/dunstrc | grep "urgency_low" -A4 | grep "frame" | cut -c '20-26')
dunstLowHighlight=$(cat $dirC/dunst/dunstrc | grep "urgency_low" -A4 | grep "highlight" | cut -c '18-24')
dunstNormalBg=$(cat $dirC/dunst/dunstrc | grep "urgency_normal" -A4 | grep "background" | cut -c '19-25')
dunstNormalFg=$(cat $dirC/dunst/dunstrc | grep "urgency_normal" -A4 | grep "foreground" | cut -c '19-25')
dunstNormalFrame=$(cat $dirC/dunst/dunstrc | grep "urgency_normal" -A4 | grep "frame" | cut -c '20-26')
dunstNormalHighlight=$(cat $dirC/dunst/dunstrc | grep "urgency_normal" -A4 | grep "highlight" | cut -c '18-24')
dunstCriticalBg=$(cat $dirC/dunst/dunstrc | grep "urgency_critical" -A4 | grep "background" | cut -c '19-25')
dunstCriticalFg=$(cat $dirC/dunst/dunstrc | grep "urgency_critical" -A4 | grep "foreground" | cut -c '19-25')
dunstCriticalFrame=$(cat $dirC/dunst/dunstrc | grep "urgency_critical" -A4 | grep "frame" | cut -c '20-26')
dunstCriticalHighlight=$(cat $dirC/dunst/dunstrc | grep "urgency_critical" -A4 | grep "highlight" | cut -c '18-24')

# Eww imports the colours.scss file directly

# Flameshot 
flameShotUI=$(cat $dirC/flameshot/flameshot.ini | grep 'uiColor' | cut -c '9-')
flameShotTool=$(cat $dirC/flameshot/flameshot.ini | grep 'drawColor' | cut -c '11-')
flameShotBg=$(cat $dirC/flameshot/flameshot.ini | grep 'contrastUiColor' | cut -c '17-')

# jgmenu
jgBg=$(cat $dirC/jgmenu/jgmenurc | grep '_menu_bg' | cut -c '22-28')
jgFg=$(cat $dirC/jgmenu/jgmenurc | grep '_norm_fg' | cut -c '22-28')
jgSelectBg=$(cat $dirC/jgmenu/jgmenurc | grep '_sel_bg' | cut -c '21-27')
jgSelectFg=$(cat $dirC/jgmenu/jgmenurc | grep '_sel_fg' | cut -c '21-27')

# Rofi
# Coming soon, ya know... once I have set it up



# ============================================
# Check if colour is already set, else, set it
# ============================================

# Alacritty
echo "Setting Alacritty colours"
if [[ $alacrittyBlack == $HEX_Black4 ]]; then :
else
    sed -i "s/'$alacrittyBlack'/'$HEX_Black4'/g" $dirC/alacritty/alacritty.yml && echo "  Black"
fi
if [[ $alacrittyRed == $HEX_Red ]]; then :
else
    sed -i "s/'$alacrittyRed'/'$HEX_Red'/g" $dirC/alacritty/alacritty.yml && echo "  Red"
fi
if [[ $alacrittyGreen == $HEX_GreenLight ]]; then :
else
    sed -i "s/'$alacrittyGreen'/'$HEX_GreenLight'/g" $dirC/alacritty/alacritty.yml && echo "  Green"
fi
if [[ $alacrittyYellow == $HEX_YellowLight ]]; then :
else
    sed -i "s/'$alacrittyYellow'/'$HEX_YellowLight'/g" $dirC/alacritty/alacritty.yml && echo "  Yellow"
fi
if [[ $alacrittyBlue == $HEX_BlueLight ]]; then :
else
    sed -i "s/'$alacrittyBlue'/'$HEX_BlueLight'/g" $dirC/alacritty/alacritty.yml && echo "  Blue"
fi
if [[ $alacrittyMagenta == $HEX_PurpleDark ]]; then :
else
    sed -i "s/'$alacrittyMagenta'/'$HEX_PurpleDark'/g" $dirC/alacritty/alacritty.yml && echo "  Magenta"
fi
if [[ $alacrittyCyan == $HEX_Cyan ]]; then :
else
    sed -i "s/'$alacrittyCyan'/'$HEX_Cyan'/g" $dirC/alacritty/alacritty.yml && echo "  Cyan"
fi
if [[ $alacrittyWhite == $HEX_White0 ]]; then :
else
    sed -i "s/'$alacrittyWhite'/'$HEX_White0'/g" $dirC/alacritty/alacritty.yml && echo "  White"
fi

# Dunst
echo "Setting Dunst colours"
# if [[ $dunstLowBg == $HEX_DynamicBg ]]; then :
# else
#     sed -i "s/$dunstLowBg/$HEX_DynamicBg/g" $dirC/dunst/dunstrc && echo "  Low Urgency BG"
# fi
# if [[ $dunstLowFg == $HEX_DynamicFg ]]; then :
# else
#     sed -i "s/$dunstLowFg/$HEX_DynamicFg/g" $dirC/dunst/dunstrc && echo "  Low Urgency FG"
# fi
# if [[ $dunstLowFrame == $HEX_Grey3 ]]; then :
# else
#     sed -i "s/$dunstLowFrame/$HEX_Grey3/g" $dirC/dunst/dunstrc && echo "  Low Urgency Frame"
# fi
# if [[ $dunstLowHighlight == $HEX_DynamicAccent ]]; then :
# else
#     sed -i "s/$dunstLowHighlight/$HEX_DynamicAccent/g" $dirC/dunst/dunstrc && echo "  Low Urgency Highlight"
# fi
if [[ $dunstNormalBg == $HEX_DynamicBg ]]; then :
else
    sed -i "s/$dunstNormalBg/$HEX_DynamicBg/g" $dirC/dunst/dunstrc && echo "  Normal Urgency BG"
fi
if [[ $dunstNormalFg == $HEX_DynamicFg ]]; then :
else
    sed -i "s/$dunstNormalFg/$HEX_DynamicFg/g" $dirC/dunst/dunstrc && echo "  Normal Urgency FG"
fi
if [[ $dunstNormalFrame == $HEX_Grey3 ]]; then :
else
    sed -i "s/$dunstNormalFrame/$HEX_Grey3/g" $dirC/dunst/dunstrc && echo "  Normal Urgency Frame"
fi
if [[ $dunstNormalHighlight == $HEX_DynamicAccent ]]; then :
else
    sed -i "s/$dunstNormalHighlight/$HEX_DynamicAccent/g" $dirC/dunst/dunstrc && echo "  Normal Urgency Highlight"
fi
if [[ $dunstCriticalBg == $HEX_Red ]]; then :
else
    sed -i "s/$dunstCriticalBg/$HEX_Red/g" $dirC/dunst/dunstrc && echo "  Critical Urgency BG"
fi
if [[ $dunstCriticalFg == $HEX_White4 ]]; then :
else
    sed -i "s/$dunstCriticalFg/$HEX_White4/g" $dirC/dunst/dunstrc && echo "  Critical Urgency FG"
fi
if [[ $dunstCriticalFrame == $HEX_Grey3 ]]; then :
else
    sed -i "s/$dunstCriticalFrame/$HEX_Grey3/g" $dirC/dunst/dunstrc && echo "  Critical Urgency Frame"
fi
if [[ $dunstCriticalHighlight == $HEX_White0 ]]; then :
else
    sed -i "s/$dunstCriticalHighlight/$HEX_White0/g" $dirC/dunst/dunstrc && echo "  Critical Urgency Highlight"
fi

# Flameshot
echo "Setting Flameshot colours"
if [[ $flameShotUI == $HEX_DynamicAccent ]]; then :
else
    sed -i "s/$flameShotUI/$HEX_DynamicAccent/g" $dirC/flameshot/flameshot.ini && echo "  UI Colours"
fi
if [[ $flameShotTool == $HEX_DynamicAccent ]]; then :
else
    sed -i "s/$flameShotTool/$HEX_DynamicAccent/g" $dirC/flameshot/flameshot.ini && echo "  Default tool colour (text, paint, etc)"
fi
if [[ $flameShotBg == $HEX_DynamicBg ]]; then :
else
    sed -i "s/$flameShotBg/$HEX_DynamicBg/g" $dirC/flameshot/flameshot.ini && echo "  Dimmed background"
fi

# jgmenu
echo "Setting jgmenu colours"
if [[ $jgBg == $HEX_DynamicBg ]]; then :
else
    sed -i "s/$jgBg/$HEX_DynamicBg/g" $dirC/jgmenu/jgmenurc && echo "  Menu BG"
fi
if [[ $jgFg == $HEX_White2 ]]; then :
else
    sed -i "s/$jgFg/$HEX_White2/g" $dirC/jgmenu/jgmenurc && echo "  Menu FG"
fi
if [[ $jgSelectBg == $HEX_DynamicAccent ]]; then :
else
    sed -i "s/$jgSelectBg/$HEX_DynamicAccent/g" $dirC/jgmenu/jgmenurc && echo "  Highlight BG"
fi
if [[ $jgSelectFg == $HEX_White2 ]]; then :
else
    sed -i "s/$jgSelectFg/$HEX_White2/g" $dirC/jgmenu/jgmenurc && echo "  Highlight FG"
fi

# Restart some software 
echo "Resetting system services"
#dunst
killall dunst & sleep .1 && dunstify Colours "System colours have been set"
#eww
#$ewwcmd kill && $ewwcmd daemon && $ewwcmd open-many desktop desktop-mouse-actions backgroundbar bar

echo "All colours set"
