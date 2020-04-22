#! /bin/bash

WM="xfconf-query -c xfwm4"
KEYBINDING="xfconf-query -c xfce4-keyboard-shortcuts"

#tiling
$KEYBINDING -p "/xfwm4/custom/<Super>Left" -r
$KEYBINDING -p "/xfwm4/custom/<Super>Page_Down" -r
$KEYBINDING -p "/xfwm4/custom/<Super>Page_Up" -r
$KEYBINDING -p "/xfwm4/custom/<Super>Right" -r

$KEYBINDING -p "/xfwm4/custom/<Super>Left" -n -t string -s "tile_left_key"
$KEYBINDING -p "/xfwm4/custom/<Super>Page_Down" -n -t string -s "tile_down_key"
$KEYBINDING -p "/xfwm4/custom/<Super>Page_Up" -n -t string -s "tile_up_key"
$KEYBINDING -p "/xfwm4/custom/<Super>Right" -n -t string -s "tile_right_key"

#whisker menu
$KEYBINDING -p "/commands/custom/<Super>d" -r
$KEYBINDING -p "/commands/custom/<Super>d" -n -t string -s "xfce4-popup-whiskermenu"

#launchers
$KEYBINDING -p "/commands/custom/<Super>Return" -r
$KEYBINDING -p "/commands/custom/<Super>p" -r
$KEYBINDING -p "/commands/custom/<Super><Shift>P" -r
$KEYBINDING -p "/commands/custom/<Super>m" -r
$KEYBINDING -p "/commands/custom/<Super>i" -r

$KEYBINDING -p "/commands/custom/<Super>Return" -n -t string -s "kitty tmux"
$KEYBINDING -p "/commands/custom/<Super>p" -n -t string -s "google-chrome"
$KEYBINDING -p "/commands/custom/<Super><Shift>P" -n -t string -s "google-chrome --incognito"
$KEYBINDING -p "/commands/custom/<Super>m" -n -t string -s "keepassxc"
$KEYBINDING -p "/commands/custom/<Super>i" -n -t string -s "doublecmd"

#workspaces
$WM -p "/general/workspace_count" -s 10

#reset bindings
for x in `$KEYBINDING -l`; do
    if `$KEYBINDING -p $x | grep -P "workspace_\d\d?_key" > /dev/null`; then
        $KEYBINDING -p $x -r
    fi
done

#set binding
$KEYBINDING -p "/xfwm4/custom/<Shift><Super>exclam" -n -t string -s "move_window_workspace_1_key"
$KEYBINDING -p "/xfwm4/custom/<Shift><Super>at" -n -t string -s "move_window_workspace_2_key"
$KEYBINDING -p "/xfwm4/custom/<Shift><Super>numbersign" -n -t string -s "move_window_workspace_3_key"
$KEYBINDING -p "/xfwm4/custom/<Shift><Super>dollar" -n -t string -s "move_window_workspace_4_key"
$KEYBINDING -p "/xfwm4/custom/<Shift><Super>percent" -n -t string -s "move_window_workspace_5_key"
$KEYBINDING -p "/xfwm4/custom/<Shift><Super>asciicircum" -n -t string -s "move_window_workspace_6_key"
$KEYBINDING -p "/xfwm4/custom/<Shift><Super>ampersand" -n -t string -s "move_window_workspace_7_key"
$KEYBINDING -p "/xfwm4/custom/<Shift><Super>asterisk" -n -t string -s "move_window_workspace_8_key"
$KEYBINDING -p "/xfwm4/custom/<Shift><Super>parenleft" -n -t string -s "move_window_workspace_9_key"
$KEYBINDING -p "/xfwm4/custom/<Shift><Super>parenright" -n -t string -s "move_window_workspace_10_key"


for i in {1..10};do
    if [ $i -eq 10 ]; then
        $KEYBINDING -p "/xfwm4/custom/<Super>0" -n -t string -s "workspace_$i""_key"
    else
        $KEYBINDING -p "/xfwm4/custom/<Super>$i" -n -t string -s "workspace_$i""_key"
    fi
done

