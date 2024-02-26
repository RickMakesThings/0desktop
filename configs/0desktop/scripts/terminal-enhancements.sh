#!/bin/bash
case $1 in


# Terminal header
termheader ) 
printf "\e[0;38;5;235m\e[38;5;239;48;5;235m󰃮 $(date +%Y-%m-%d)\e[38;5;235;48;5;237m 󱑂 $(date +%H:%M)\e[38;5;237;48;5;239m  $SHELL\e[38;5;239;48;5;241m  $BASH_VERSION\e[38;5;241;48;5;243m 󰅩 $LANG\e[0;38;5;243m\e[0m \n
\e[0;38;5;245m\e[38;5;239;48;5;245m $HOSTNAME\e[38;5;245;48;5;243m  $UID\e[38;5;243;48;5;241m 󰉋 $HOME\e[38;5;241;48;5;239m 󰋚 $HISTFILE\e[38;5;239;48;5;237m  $HISTSIZE\e[38;5;237;48;5;235m 󰍹 $XDG_SESSION_TYPE\e[0;38;5;235m\e[0m\n
\0"
ls --group-directories-first --color
;;

# User prompt
termprompt ) 
echo "\n\n\[\e[0;38;5;240m\]\[\e[38;5;244;48;5;240m\]\[\e[38;5;245m\] \[\e[38;5;245m\]\u \[\e[38;5;240;48;5;245m\]  \A \[\e[38;5;245;48;5;4m\]\[\e[38;5;250m\] 󰉋\[\e[38;5;245m\] \w \[\e[38;5;107;48;5;4m\]\[\e[38;5;240;48;5;107m\] 󱐋 \[\e[0;38;5;107m\]󱕆󱕆\[\e[48;5;107m\] \[\e[0;38;5;107m\] "
;;

# Command completion check
termcheck ) 
echo "\e[0;38;5;245m\e[38;5;2m\e[38;5;245m \A \n\n\0"
;;

# Fancy ls
ls )
for file in *; do #echo
	read -r user created modified filetype < <(stat --printf '%U %W %Z %F' "$file")

createddate=$(date -d @"$created" +'󱫣 %Y-%m-%d %H:%M')
modifieddate=$(date -d @"$modified" +'󱫥 %Y-%m-%d  %H:%M ')

size=$(du -sh "$file" | cut -d '	' -f1)

if [[ "$filetype" == "directory" ]]; then
	id="\e[0;38;5;4m\e[38;5;250;48;5;4m\e[1;38;5;253m $file \e[22;38;5;4;47m"
elif [[ "$filetype" == "regular empty file" ]]; then
	id="\e[0;38;5;7m\e[38;5;8;48;5;7m󰛲 \e[9m $file \e[29;38;5;7;47m"
elif [[ "$file" == *".zip"* || "$file" == *".rar"* || "$file" == *".gz" ]]; then
	id="\e[0;38;5;15m\e[38;5;214;48;5;15m \e[38;5;8m$file \e[38;5;15;47m"
elif [[ "$file" == *".png" || "$file" == *".jpg" || "$file" == *".jpeg" || "$file" == *".gif"* || "$file" == *".bmp" ]]; then
	id="\e[0;38;5;15m\e[38;5;8;48;5;15m $file \e[38;5;15;47m"
elif [[ "$file" == *".xcf" || "$file" == *".TIF" || "$file" == *".psd" ]]; then
	id="\e[0;38;5;15m\e[38;5;8;48;5;15m󱇤 $file \e[38;5;15;47m"
elif [[ "$file" == *".mp4"* || "$file" == *".mkv" || "$file" == *".mov" || "$file" == *".mpg" || "$file" == *".mpeg" || "$file" == *".m4v" || "$file" == *".flv" || "$file" == *".webm" ]]; then
	id="\e[0;38;5;15m\e[38;5;8;48;5;15m $file \e[38;5;15;47m"
elif [[ "$file" == *".mp3" || "$file" == *".m4a" || "$file" == *".aac" || "$file" == *".flac" || "$file" == *".wav" ]]; then
	id="\e[0;38;5;15m\e[38;5;8;48;5;15m $file \e[38;5;15;47m"
elif [[ "$file" == *".pdf" ]]; then
	id="\e[0;38;5;15m\e[38;5;1;48;5;15m\e[38;5;8m $file \e[38;5;15;47m"
elif [[ "$file" == *".odt" || "$file" == *".doc"* ]]; then
	id="\e[0;38;5;15m\e[38;5;25;48;5;15m\e[38;5;8m $file \e[38;5;15;47m"
elif [[ "$file" == *".ods" || "$file" == *".csv"* || "$file" == *".xls"* ]]; then
	id="\e[0;38;5;15m\e[38;5;34;48;5;15m󰱿\e[38;5;8m $file \e[38;5;15;47m"
else
	id="\e[0;38;5;15m\e[38;5;8;48;5;15m $file \e[38;5;15;47m"
fi

printf "$id\e[30;47m  $size\e[37;100m\e[30;100m  $user\e[0;90m\e[0;90m\n   󱞩 $modifieddate $createddate\e[0m \n\0"

done
;;



# Cheat Sheet 0 - Aliases
cheat0 )
	printf "\e[38;5;237m󰛃 󰛀  Scroll \n /   Search forward \n ?   Search backwards \n q   Quit \n\n
\n\e[0;1;4m󱌲 ALIASES:\e[0;90m\n
Escape aliases with '\\\' For instance: \\ls will use the original ls instead of stat \n
\e[0;90m\e[30;100mcheat0\e[0;90m      This cheat sheet \n
\e[0;90m\e[30;100mcheat1\e[0;90m      Global variables \n
\e[0;90m\e[30;100mcheat2\e[0;90m      Keyboard shortcuts \n
\e[0;90m\e[30;100mcheat3\e[0;90m      Colour codes & glyphs \n
\e[0;90m\e[30;100m0fetch\e[0;90m      Fancy, fully customisable fetch \n\n
\e[1m0desktop\e[0;90m\n
\e[0;90m\e[30;100meww-do\e[0;90m      Execute eww commands\n
\e[0;90m\e[30;100mdunst-r\e[0;90m     Reload dunst notifications\n
\e[0;90m\e[30;100mpicom-r\e[0;90m     Reload picom compositor\n
\e[0;90m\e[30;100mstalone-r\e[0;90m   Reload stalone tray application\n\n
\e[1mcd commands\e[0;90m\n
\e[0;90m\e[30;100mcd0\e[0;90m         Go to 0desktop directory and show folders/files\n
\e[0;90m\e[30;100mcd~\e[0;90m         cd ~ (home), but without the space\n
\e[0;90m\e[30;100mcd..\e[0;90m        cd .. (up one directory), but without the space\n
\e[0;90m\e[30;100mcdc\e[0;90m         ~/.config folder\n
\e[0;90m\e[30;100mcds\e[0;90m         ~/.local/share folder\n
\e[0;90m\e[30;100mccd\e[0;90m         Copy Current Directory\n\n
\e[1mls/stat/tree commands\e[0;90m\n
\e[0;90m\e[30;100mls\e[0;90m          Fancy ls that is actually stat\n
\e[0;90m\e[30;100mls-\e[0;90m         The actual ls view with some useful flags\n
\e[0;90m\e[30;100mls+\e[0;90m         Like ls-, but including ALL (hidden) items\n
\e[0;90m\e[30;100mtree\e[0;90m        Standard tree view with flags\n
\e[0;90m\e[30;100mtree[1/2/3]\e[0;90m Like tree, but show only [1/2/3] directory layers\n\n
\e[1mdnf commands\e[0;90m\n
\e[0;90m\e[30;100msd\e[0;90m          sudo dnf\n
\e[0;90m\e[30;100msearch\e[0;90m      sudo dnf search\n
\e[0;90m\e[30;100minstall\e[0;90m     sudo dnf install\n
\e[0;90m\e[30;100mremove\e[0;90m      sudo dnf remove\n
\e[0;90m\e[30;100mupdateall\e[0;90m   One command to update rpms & flatpaks\n\n
\0"
;;



# Cheat sheet 1 - Global Environment Variables
cheat1 )
 printf "\e[38;5;237m󰛃 󰛀  Scroll \n /   Search forward \n ?   Search backwards \n q   Quit \n\n
\n\e[0;1;4m GLOBAL EVIRONMENT VARIABLES:\e[0;90m
Can be used in any script, terminal, command, etc
Customise in ~/.bashrc\n\n\n
\e[1mSet variables\e[22m \n
Directories \n
\e[0;38;5;240m\e[38;5;12;48;5;240m\$dir0\e[0;38;5;240m\e[90m       The Directory to the 0desktop folder \n
\e[0;38;5;240m\e[38;5;12;48;5;240m\$dirH\e[0;38;5;240m\e[90m       The Directory to the Home (~) folder \n
\e[0;38;5;240m\e[38;5;12;48;5;240m\$dirC\e[0;38;5;240m\e[90m       The Directory to the ~/.config folder \n
\e[0;38;5;240m\e[38;5;12;48;5;240m\$direww\e[0;38;5;240m\e[90m     The Directory to the EWW folder \n\n
Commands \n
\e[0;38;5;240m\e[38;5;12;48;5;240m\$ewwcmd\e[0;38;5;240m\e[90m     Execute EWW commands \n
\e[0;38;5;240m\e[38;5;12;48;5;240m\$jgcmd\e[0;38;5;240m\e[90m      Execute jgmenu.csv \n
\e[0;38;5;240m\e[38;5;12;48;5;240m\$wttr\e[0;38;5;240m\e[90m       curl wttr.in/[location]?format= \n\n

\e[1mVariable variables\e[22m \n
\0"
;;



# Cheat sheet 2 - Keyboard shortcuts
cheat2 )
 printf "\e[38;5;237m󰛃 󰛀  Scroll \n /   Search forward \n ?   Search backwards \n q   Quit \n\n
\n\e[0;1;4m󰌌 SHORTCUTS:\e[0;90m\n\n
\e[1mGeneral\e[0;90m\n
\e[0;90m\e[30;100mCtrl\e[0;90m + \e[0;90m\e[30;100mL\e[0;90m      Clear the screen, like 'clear' command \n
\e[0;90m\e[30;100mCtrl\e[0;90m + \e[0;90m\e[30;100mR\e[0;90m      History search (ctrl+j to edit) \n                  (alt+r to revert changes to commands)
\n\e[1mCursor\e[0;90m\n
\e[0;90m\e[30;100mCtrl\e[0;90m + \e[0;90m\e[30;100ma\e[0;90m      Go to start of line \n
\e[0;90m\e[30;100mCtrl\e[0;90m + \e[0;90m\e[30;100me\e[0;90m      Go to end of line \n
 \e[0;90m\e[30;100mAlt\e[0;90m + \e[0;90m\e[30;100mb\e[0;90m      Back one word \n
 \e[0;90m\e[30;100mAlt\e[0;90m + \e[0;90m\e[30;100mf\e[0;90m      Forward one word \n
\n\e[1mEditing\e[0;90m\n
 \e[0;90m\e[30;100mAlt\e[0;90m + \e[0;90m\e[30;100mBs\e[0;90m     Delete word before the cursor \n
\e[0;90m\e[30;100mCtrl\e[0;90m + \e[0;90m\e[30;100mDel\e[0;90m    Delete word after the cursor \n
\e[0;90m\e[30;100mCtrl\e[0;90m + \e[0;90m\e[30;100mw\e[0;90m      Cut word before the cursor to clipboard \n
\e[0;90m\e[30;100mCtrl\e[0;90m + \e[0;90m\e[30;100mu\e[0;90m      Cut line before the cursor to clipboard \n
\e[0;90m\e[30;100mCtrl\e[0;90m + \e[0;90m\e[30;100mk\e[0;90m      Cut line after the cursor to clipboard \n
\e[0;90m\e[30;100mCtrl\e[0;90m + \e[0;90m\e[30;100my\e[0;90m      Paste \n
\e[0;90m\e[30;100mCtrl\e[0;90m + \e[0;90m\e[30;100m_\e[0;90m      Undo \n
\n\e[1mCommands\e[0;90m\n
\e[0;90m\e[30;100mCtrl\e[0;90m + \e[0;90m\e[30;100ms\e[0;90m      Stop command output \n
\e[0;90m\e[30;100mCtrl\e[0;90m + \e[0;90m\e[30;100mz\e[0;90m      Suspend command execution \n
\e[0;90m\e[30;100mCtrl\e[0;90m + \e[0;90m\e[30;100mq\e[0;90m      Resume suspended command \n\n\n
\0"
;;



# Cheat sheet 3 - Colour codes & glyphs
cheat3 ) 
 printf "\e[38;5;237m󰛃 󰛀  Scroll \n /   Search forward \n ?   Search backwards \n q   Quit \n\n
\n\e[0;1;4m COLOUR CODES:\e[0;90m\n
Colour codes for bash. Use \\\ to escape where necessary. Example: \\\e[0m (to reset)
Stick to syntax e[fg;bgm for convenience \n\n
\e[1m             foreground    background        bright fg    bright bg \n \e[22m
white         \e[37;0m\\\e[37m       \e[30;47m  \\\e[47m  \e[97;0m         \\\e[97m     \e[30;107m \\\e[0;107m \e[0;90m
black         \e[30;100m\\\e[30m\e[0;90m         \\\e[40m  \e[0;90m         \\\e[90m     \e[30;100m \\\e[0;100m \e[0;90m
red           \e[0;31m\\\e[31m       \e[30;41m  \\\e[41m  \e[0;91m         \\\e[91m     \e[30;101m \\\e[0;101m \e[0;90m
yellow        \e[0;33m\\\e[33m       \e[30;43m  \\\e[43m  \e[0;93m         \\\e[93m     \e[30;103m \\\e[0;103m \e[0;90m
green         \e[0;32m\\\e[32m       \e[30;42m  \\\e[42m  \e[0;92m         \\\e[92m     \e[30;102m \\\e[0;102m \e[0;90m
teal          \e[0;36m\\\e[36m       \e[30;46m  \\\e[46m  \e[0;96m         \\\e[96m     \e[30;106m \\\e[0;106m \e[0;90m
blue          \e[0;34m\\\e[34m       \e[30;44m  \\\e[44m  \e[0;94m         \\\e[94m     \e[30;104m \\\e[0;104m \e[0;90m
magenta       \e[0;35m\\\e[35m       \e[30;45m  \\\e[45m  \e[0;95m         \\\e[95m     \e[30;105m \\\e[0;105m \e[0;90m \n
\n
\e[0;1m256-color-mode\e[0;90m \n\nforeground: \\\e[38;5;#m \nbackground: \\\e[48;5;#m \ncombined:   \\\e[38;5;fg;48;5;bgm

\e[1mstandard colours            high-intensity colours\e[0m
\e[38;5;15;48;5;0m 0 \e[38;5;15;48;5;1m 1 \e[38;5;15;48;5;2m 2 \e[38;5;15;48;5;3m 3 \e[38;5;15;48;5;4m 4 \e[38;5;15;48;5;5m 5 \e[38;5;15;48;5;6m 6 \e[38;5;15;48;5;7m 7 \e[0m    \e[38;5;0;48;5;8m 8 \e[38;5;0;48;5;9m 9 \e[38;5;0;48;5;10m 10 \e[38;5;0;48;5;11m 11 \e[38;5;0;48;5;12m 12 \e[38;5;0;48;5;13m 13 \e[38;5;0;48;5;14m 14 \e[38;5;0;48;5;15m 15 \e[0;90m

\e[1mcolour blocks\e[22m\n\e[38;5;15;48;5;16m  16\e[38;5;15;48;5;17m  17\e[38;5;15;48;5;18m  18\e[38;5;15;48;5;19m  19\e[38;5;15;48;5;20m  20\e[38;5;15;48;5;21m  21\e[0m    \e[38;5;15;48;5;22m  22\e[38;5;15;48;5;23m  23\e[38;5;15;48;5;24m  24\e[38;5;15;48;5;25m  25\e[38;5;15;48;5;26m  26\e[38;5;15;48;5;27m  27\e[0m    \e[38;5;15;48;5;28m  28\e[38;5;15;48;5;29m  29\e[38;5;15;48;5;30m  30\e[38;5;15;48;5;31m  31\e[38;5;15;48;5;32m  32\e[38;5;15;48;5;33m  33\e[0m
\e[38;5;15;48;5;52m  52\e[38;5;15;48;5;53m  53\e[38;5;15;48;5;54m  54\e[38;5;15;48;5;55m  55\e[38;5;15;48;5;56m  56\e[38;5;15;48;5;57m  57\e[0m    \e[38;5;15;48;5;58m  58\e[38;5;15;48;5;59m  59\e[38;5;15;48;5;60m  60\e[38;5;15;48;5;61m  61\e[38;5;15;48;5;62m  62\e[38;5;15;48;5;63m  63\e[0m    \e[38;5;15;48;5;64m  64\e[38;5;15;48;5;65m  65\e[38;5;15;48;5;66m  66\e[38;5;15;48;5;67m  67\e[38;5;15;48;5;68m  68\e[38;5;15;48;5;69m  69\e[0m
\e[38;5;15;48;5;88m  88\e[38;5;15;48;5;89m  89\e[38;5;15;48;5;90m  90\e[38;5;15;48;5;91m  91\e[38;5;15;48;5;92m  92\e[38;5;15;48;5;93m  93\e[0m    \e[38;5;15;48;5;94m  94\e[38;5;15;48;5;95m  95\e[38;5;15;48;5;96m  96\e[38;5;15;48;5;97m  97\e[38;5;15;48;5;98m  98\e[38;5;15;48;5;99m  99\e[0m    \e[38;5;15;48;5;100m 100\e[38;5;15;48;5;101m 101\e[38;5;15;48;5;102m 102\e[38;5;15;48;5;103m 103\e[38;5;15;48;5;104m 104\e[38;5;15;48;5;105m 105\e[0m
\e[38;5;15;48;5;124m 124\e[38;5;15;48;5;125m 125\e[38;5;15;48;5;126m 126\e[38;5;15;48;5;127m 127\e[38;5;15;48;5;128m 128\e[38;5;15;48;5;129m 129\e[0m    \e[38;5;15;48;5;130m 130\e[38;5;15;48;5;131m 131\e[38;5;15;48;5;132m 132\e[38;5;15;48;5;133m 133\e[38;5;15;48;5;134m 134\e[38;5;15;48;5;135m 135\e[0m    \e[38;5;15;48;5;136m 136\e[38;5;15;48;5;137m 137\e[38;5;15;48;5;138m 138\e[38;5;15;48;5;139m 139\e[38;5;15;48;5;140m 140\e[38;5;15;48;5;141m 141\e[0m
\e[38;5;15;48;5;160m 160\e[38;5;15;48;5;161m 161\e[38;5;15;48;5;162m 162\e[38;5;15;48;5;163m 163\e[38;5;15;48;5;164m 164\e[38;5;15;48;5;165m 165\e[0m    \e[38;5;15;48;5;166m 166\e[38;5;15;48;5;167m 167\e[38;5;15;48;5;168m 168\e[38;5;15;48;5;169m 169\e[38;5;15;48;5;170m 170\e[38;5;15;48;5;171m 171\e[0m    \e[38;5;15;48;5;172m 172\e[38;5;15;48;5;173m 173\e[38;5;15;48;5;174m 174\e[38;5;15;48;5;175m 175\e[38;5;15;48;5;176m 176\e[38;5;15;48;5;177m 177\e[0m
\e[38;5;15;48;5;196m 196\e[38;5;15;48;5;197m 197\e[38;5;15;48;5;198m 198\e[38;5;15;48;5;199m 199\e[38;5;15;48;5;200m 200\e[38;5;15;48;5;201m 201\e[0m    \e[38;5;15;48;5;202m 202\e[38;5;15;48;5;203m 203\e[38;5;15;48;5;204m 204\e[38;5;15;48;5;205m 205\e[38;5;15;48;5;206m 206\e[38;5;15;48;5;207m 207\e[0m    \e[38;5;15;48;5;208m 208\e[38;5;15;48;5;209m 209\e[38;5;15;48;5;210m 210\e[38;5;15;48;5;211m 211\e[38;5;15;48;5;212m 212\e[38;5;15;48;5;213m 213\e[0m\n\n
\e[38;5;0;48;5;34m  34\e[38;5;0;48;5;35m  35\e[38;5;0;48;5;36m  36\e[38;5;0;48;5;37m  37\e[38;5;0;48;5;38m  38\e[38;5;0;48;5;39m  39\e[0m    \e[38;5;0;48;5;40m  40\e[38;5;0;48;5;41m  41\e[38;5;0;48;5;42m  42\e[38;5;0;48;5;43m  43\e[38;5;0;48;5;44m  44\e[38;5;0;48;5;45m  45\e[0m    \e[38;5;0;48;5;46m  46\e[38;5;0;48;5;47m  47\e[38;5;0;48;5;48m  48\e[38;5;0;48;5;49m  49\e[38;5;0;48;5;50m  50\e[38;5;0;48;5;51m  51\e[0m
\e[38;5;0;48;5;70m  70\e[38;5;0;48;5;71m  71\e[38;5;0;48;5;72m  72\e[38;5;0;48;5;73m  73\e[38;5;0;48;5;74m  74\e[38;5;0;48;5;75m  75\e[0m    \e[38;5;0;48;5;76m  76\e[38;5;0;48;5;77m  77\e[38;5;0;48;5;78m  78\e[38;5;0;48;5;79m  79\e[38;5;0;48;5;80m  80\e[38;5;0;48;5;81m  81\e[0m    \e[38;5;0;48;5;82m  82\e[38;5;0;48;5;83m  83\e[38;5;0;48;5;84m  84\e[38;5;0;48;5;85m  85\e[38;5;0;48;5;86m  86\e[38;5;0;48;5;87m  87\e[0m
\e[38;5;0;48;5;106m 106\e[38;5;0;48;5;107m 107\e[38;5;0;48;5;108m 108\e[38;5;0;48;5;109m 109\e[38;5;0;48;5;110m 110\e[38;5;0;48;5;111m 111\e[0m    \e[38;5;0;48;5;112m 112\e[38;5;0;48;5;113m 113\e[38;5;0;48;5;114m 114\e[38;5;0;48;5;115m 115\e[38;5;0;48;5;116m 116\e[38;5;0;48;5;117m 117\e[0m    \e[38;5;0;48;5;118m 118\e[38;5;0;48;5;119m 119\e[38;5;0;48;5;120m 120\e[38;5;0;48;5;121m 121\e[38;5;0;48;5;122m 122\e[38;5;0;48;5;123m 123\e[0m
\e[38;5;0;48;5;142m 142\e[38;5;0;48;5;143m 143\e[38;5;0;48;5;144m 144\e[38;5;0;48;5;145m 145\e[38;5;0;48;5;146m 146\e[38;5;0;48;5;147m 147\e[0m    \e[38;5;0;48;5;148m 148\e[38;5;0;48;5;149m 149\e[38;5;0;48;5;150m 150\e[38;5;0;48;5;151m 151\e[38;5;0;48;5;152m 152\e[38;5;0;48;5;153m 153\e[0m    \e[38;5;0;48;5;154m 154\e[38;5;0;48;5;155m 155\e[38;5;0;48;5;156m 156\e[38;5;0;48;5;157m 157\e[38;5;0;48;5;158m 158\e[38;5;0;48;5;159m 159\e[0m
\e[38;5;0;48;5;178m 178\e[38;5;0;48;5;179m 179\e[38;5;0;48;5;180m 180\e[38;5;0;48;5;181m 181\e[38;5;0;48;5;182m 182\e[38;5;0;48;5;183m 183\e[0m    \e[38;5;0;48;5;184m 184\e[38;5;0;48;5;185m 185\e[38;5;0;48;5;186m 186\e[38;5;0;48;5;187m 187\e[38;5;0;48;5;188m 188\e[38;5;0;48;5;189m 189\e[0m    \e[38;5;0;48;5;190m 190\e[38;5;0;48;5;191m 191\e[38;5;0;48;5;192m 192\e[38;5;0;48;5;193m 193\e[38;5;0;48;5;194m 194\e[38;5;0;48;5;195m 195\e[0m
\e[38;5;0;48;5;214m 214\e[38;5;0;48;5;215m 215\e[38;5;0;48;5;216m 216\e[38;5;0;48;5;217m 217\e[38;5;0;48;5;218m 218\e[38;5;0;48;5;219m 219\e[0m    \e[38;5;0;48;5;220m 220\e[38;5;0;48;5;221m 221\e[38;5;0;48;5;222m 222\e[38;5;0;48;5;223m 223\e[38;5;0;48;5;224m 224\e[38;5;0;48;5;225m 225\e[0m    \e[38;5;0;48;5;226m 226\e[38;5;0;48;5;227m 227\e[38;5;0;48;5;228m 228\e[38;5;0;48;5;229m 229\e[38;5;0;48;5;230m 230\e[38;5;0;48;5;231m 231\e[0;90m

\e[1mgrayscale codes\e[22m\n\e[38;5;15;48;5;232m 232\e[38;5;15;48;5;233m 233\e[38;5;15;48;5;234m 234\e[38;5;15;48;5;235m 235\e[38;5;15;48;5;236m 236\e[38;5;15;48;5;237m 237\e[38;5;15;48;5;238m 238\e[38;5;15;48;5;239m 239\e[38;5;15;48;5;240m 240\e[38;5;15;48;5;241m 241\e[38;5;15;48;5;242m 242\e[38;5;15;48;5;243m 243\e[0m\n\e[38;5;0;48;5;244m 244\e[38;5;0;48;5;245m 245\e[38;5;0;48;5;246m 246\e[38;5;0;48;5;247m 247\e[38;5;0;48;5;248m 248\e[38;5;0;48;5;249m 249\e[38;5;0;48;5;250m 250\e[38;5;0;48;5;251m 251\e[38;5;0;48;5;252m 252\e[38;5;0;48;5;253m 253\e[38;5;0;48;5;254m 254\e[38;5;0;48;5;255m 255\e[0;90m\n\n\n

\e[1;38;2;255;0;0mR\e[38;2;0;255;0mG\e[38;2;0;0;255mB\e[37m colours\e[0;90m\n
Use RGB colour codes, where R, G and B can be assigned a value between 0-255\n
foreground: \\\e[38;2;R;G;Bm \nbackground: \\\e[48;2;R;G;Bm \ncombined:   \\\e[38;2;R;G;B;48;2;R;G;Bm

\e[1mExamples\n\e[22;38;2;255;0;0m\\\e[38;2;255;0;0m   \e[38;2;0;0;0;48;2;255;0;0m \\\e[38;2;0;0;0;48;2;255;0;0m       \e[0m\n\e[38;2;0;255;0m\\\e[38;2;0;255;0m   \e[38;2;0;0;0;48;2;0;255;0m \\\e[38;2;0;0;0;48;2;0;255;0m       \e[0m\n\e[38;2;0;0;255m\\\e[38;2;0;0;255m\e[0m   \e[38;2;255;255;255;48;2;0;0;255m \\\e[38;2;255;255;255;48;2;0;0;255m \e[0m\n                   \e[38;2;0;0;0;48;2;255;255;255m \\\e[38;2;0;0;0;48;2;255;255;255m   \e[0;90m\n\n
|0       |100    |200    |255
\e[30;48;2;10;0;0m \e[30;48;2;20;0;0m \e[30;48;2;30;0;0m \e[30;48;2;40;0;0m \e[30;48;2;50;0;0m \e[30;48;2;60;0;0m \e[30;48;2;70;0;0m \e[30;48;2;80;0;0m \e[30;48;2;90;0;0m \e[30;48;2;100;0;0m \e[30;48;2;110;0;0m \e[30;48;2;120;0;0m \e[30;48;2;130;0;0m \e[30;48;2;140;0;0m \e[30;48;2;150;0;0m \e[30;48;2;160;0;0m \e[30;48;2;170;0;0m \e[30;48;2;180;0;0m \e[30;48;2;190;0;0m \e[30;48;2;200;0;0m \e[30;48;2;210;0;0m \e[30;48;2;220;0;0m \e[30;48;2;230;0;0m \e[30;48;2;240;0;0m \e[30;48;2;250;0;0m \e[30;48;2;255;0;0m \e[0;90m
0;0;0 -steps of 10- 255;0;0

\n\n\n\e[0;1;4m󰛖 ADDITIONAL FORMAT OPTIONS:\e[0;90m\n\nUse these in front of your colour code as follows: \\\e[x;38;5;15m \nUse multiple: \\\e[x;x;x;38;5;15m\n
\e[1;4mCode   Syntax      Function            \e[0;90m
 0     \\\e[0m       Reset all formatting
 1     \\\e[1m       \e[1mBold text\e[0;90m
 2     \\\e[2m       \e[2;38;5;238mFaint text\e[0;90m
 3     \\\e[3m       \e[3mItalic text (bold)\e[0;90m
 4     \\\e[4m       \e[4mUnderline\e[0;90m
 9     \\\e[9m       \e[9mCrossed out\e[0;90m \n
22    \\\e[22m       Bold/Faint off
23    \\\e[23m       Italics off
24    \\\e[24m       Underline off
29    \\\e[29m       Crossed out off \n
39    \\\e[39m       Unset foreground colour
49    \\\e[49m       Unset background colour


\n\n\e[0;1;4m󰉺 GLYPHS:\e[0;90m\n
Line transitions                                                   \n\n                                               \n
Lines                     󱋰     󰇜     󱕆     󰇘           󰮸      󰭅                  \n\n
Bash                           󱆃                                                 \n
Git                                           󰮠                           \n                                                                         \n                                                                           \n
Computer             󰪫     󰇅          󰧨          󰇄          󰌢     󱩊              \n                          󰋊     󱁋     󱁌     󰍛          󰻟     󰻠          󰘚      \n                     󰌌          󰥻     󰌓     󱊷     󰌒     󰘶     󱁐     󰌍     󰌑        \n
Folders & files      󰉋                                                  󱞞  \n                     󱂵     󰉌          󰉏     󱍙     󰉍     󰛫     󰣞     󱞊     󱃪     󰡰 \n                          󰈔                              󰱾     󰱿            \n                     󰈫     󰸬                         󰘓     󱇤 \n
User                                                         󱐡     󰗹        \n                     󱐢     󰁵                                                    \n
Arrows                                                  󰁁          󰘕     󰘖  \n                                         󰳡     󰳛     󰳝     󰳟     󰁌     󰤻     󰤼 \n                     󰛃     󰛀     󰛁     󰛂     󱖗     󱖙     󱖚     󱖘     󰦻     󰑁     󰑃  \n                     󱞥     󱞩     󱞧     󱞫     󱞽     󱞿     󱞡     󱞣
\0"
;;



# Custom fetch
0fetch )

# Fetch system info
name=$(hostnamectl | grep 'Pretty host' | cut -d ':' -f2 | cut -c '2-')
os=$(hostnamectl | grep 'ing System' | cut -d ':' -f2 | cut -d '(' -f1 | cut -c '2-')
support=$(hostnamectl | grep 'Support End' | cut -d ':' -f2 | cut -c '2-')
kernel=$(hostnamectl | grep 'Kernel' | cut -d ':' -f2 | cut -d ' ' -f3)
uptime=$(uptime -p | cut -d ' ' -f2,3,4,5)
shell=$(echo "$BASH_VERSION" | cut -d '-' -f1)

# Fetch theming info
wm=$(wmctrl -m | grep 'Name:' | cut -d ' ' -f2)
theme=$(gsettings get org.gnome.desktop.interface gtk-theme)
icons=$(gsettings get org.gnome.desktop.interface icon-theme)

# Fetch pc hardware info
cpubrand=$(lscpu | grep 'Model name:' | cut -d ' ' -f27 | cut -d '(' -f1)
cpuseries=$(lscpu | grep 'Model name:' | cut -d ' ' -f28 | cut -d '(' -f1)
cpumodel=$(lscpu | grep 'Model name:' | cut -d ' ' -f29 | cut -d '(' -f1)
cpucores=$(lscpu | grep 'Core(s) per socket:' | cut -d ' ' -f20)
cputhreads=$(lscpu | grep 'CPU(s):' | cut -d ' ' -f30)
cpuspeed1=$(lscpu | grep 'CPU max MHz:' | cut -d ' ' -f27 | cut  -c '1')
cpuspeed2=$(lscpu | grep 'CPU max MHz:' | cut -d ' ' -f27 | cut  -c '2')
cpuarch=$(hostnamectl | grep 'Architecture' | cut -d ':' -f2)
ramused=$(free | grep 'Mem:' | cut -c '25,26')
ramusedmb=$(free | grep 'Mem:' | cut -c '27-29')
ramtotal=$(free | grep 'Mem:' | cut -c '13,14')
romused=$(lsblk -l --bytes --output NAME,FSSIZE,FSUSED,FSUSE% | grep '%' | tail -n1 | cut -c '24-26')
romusedpercent=$(lsblk -l --bytes --output NAME,FSSIZE,FSUSED,FSUSE% | grep '%' | tail -n1 | cut -c '40,41')
romtotal=$(lsblk -l --bytes --output NAME,FSSIZE,FSUSED,FSUSE% | grep '%' | tail -n1 | cut -c '11-13')

# Trim $ramused string if only 1 character (<10GB). Replace with mb if <1GB
if		[[ $ramused == "  " ]]; then
			usedram="$ramusedmb MB"
elif 	[[ $ramused == " "* ]]; then
			usedram=$(echo "$ramused" | cut -c '2-')
else
		usedram=$ramused 
fi

# Format hardware info
cpu="$cpubrand $cpuseries $cpumodel $cpucores"c/"$cputhreads"t" @ $cpuspeed1.$cpuspeed2"GHz""
ram="$usedram"/"$ramtotal GB"
rom="$romused/$romtotal GB - $romusedpercent%% full"
motherboard=$(hostnamectl | grep 'Vendor' | cut -d ':' -f2 | cut -c '2-')
gpu=$(lspci | grep 'VGA' | cut -d '[' -f2 | cut -d ']' -f1)

# Output 
printf "\n\e[0m
\e[38;5;4m             .',;::::;,'.                
\e[38;5;4m         .';::;,.\e[38;5;239m     \e[4m$name \e[24m
\e[38;5;4m      .;;.         
\e[38;5;4m    .::.\e[38;5;240m     $os     
\e[38;5;4m  .;;\e[38;5;244m.:dddl:.\e[38;5;4m;;.\e[38;5;241m   󰃰  $support   
\e[38;5;4m .:\e[38;5;245m;OWMKOOXMWd\e[38;5;4m;:.\e[38;5;242m     $kernel  
\e[38;5;4m.:\e[38;5;246m;KMM;\e[38;5;4m;\e[38;5;246mxMM\e[38;5;4m::.\e[38;5;243m     $shell 
\e[38;5;4m,\e[38;5;247m;MMM.\e[38;5;4m;;\e[38;5;247m;WW:\e[38;5;4m:,\e[38;5;244m   󰔛  $uptime
\e[38;5;4m:\e[38;5;248m;MMM.\e[38;5;4m;:    
\e[38;5;4m:\e[38;5;249m;oxOOOo;MMM0OOk.\e[38;5;4m;:\e[38;5;245m     $cpu
\e[38;5;4m\e[38;5;250m:0MMKxdd\e[38;5;4m:\e[38;5;250m;MMMkdd.\e[38;5;4m;;\e[38;5;246m     $ram
\e[38;5;4m\e[38;5;251m:XM0'\e[38;5;4m;\e[38;5;251m;MMM.\e[38;5;4m;'\e[38;5;247m     $motherboard 
\e[38;5;4m\e[38;5;252m;MMo\e[38;5;4m;\e[38;5;252m;MMW.\e[38;5;4m;;\e[38;5;248m     $rom
\e[38;5;4m\e[38;5;253m;0MN.\e[38;5;4m\e[38;5;253m.xMMd\e[38;5;4m:;\e[38;5;249m   󱄄  $gpu
\e[38;5;4m\e[38;5;254m;dNMWXXXWM0:\e[38;5;4m::, 
\e[38;5;4m;\e[38;5;255m.:odl:.\e[38;5;4m;:,.\e[38;5;250m   $theme        
\e[38;5;4m::'.\e[38;5;252m   $icons       
\e[38;5;4m.::;,..\e[38;5;255m   '$wm'             \e[30m \e[31m \e[32m \e[33m \e[34m \e[35m \e[36m \e[37m 
\e[38;5;4m  '::::;,.\e[0;38;5;0m                           \e[90m \e[91m \e[92m \e[93m \e[94m \e[95m \e[96m \e[97m
                                                                                               
\e[0m\0"
;;

esac

#
# Without the colour codes:
#

#              .',;::::;,'.                
#          .';:cccccccccccc:;,.     \e[4m$name \e[24m
#       .;cccccccccccccccccccccc;.         
#     .:cccccccccccccccccccccccccc:.     $os     
#   .;ccccccccccccc;.:dddl:.;ccccccc;.   󰃰  $support   
#  .:ccccccccccccc;OWMKOOXMWd;ccccccc:.     $kernel  
# .:ccccccccccccc;KMMc;cc;xMMc:ccccccc:.     $shell 
# ,cccccccccccccc;MMM.;cc;;WW::cccccccc,   󰔛  $uptime
# :cccccccccccccc;MMM.;cccccccccccccccc:    
# :ccccccc;oxOOOo;MMM0OOk.;cccccccccccc:     $cpu
# cccccc:0MMKxdd:;MMMkddc.;cccccccccccc;     $ram
# ccccc:XM0';cccc;MMM.;cccccccccccccccc'     $motherboard 
# ccccc;MMo;ccccc;MMW.;ccccccccccccccc;     $rom
# ccccc;0MNc.ccc.xMMd:ccccccccccccccc;   󱄄  $gpu
# cccccc;dNMWXXXWM0::cccccccccccccc:, 
# cccccccc;.:odl:.;cccccccccccccc:,.   $theme        
# :cccccccccccccccccccccccccccc:'.   $icons       
# .:cccccccccccccccccccccc:;,..   '$wm'             \e[30m \e[31m \e[32m \e[33m \e[34m \e[35m \e[36m \e[37m 
#   '::cccccccccccccc::;,.   '$wm'             \e[90m \e[91m \e[92m \e[93m \e[94m \e[95m \e[96m \e[97m    
