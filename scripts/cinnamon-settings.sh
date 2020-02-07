#! /bin/bash

#--------------
#remove conflicting keybinds
#--------------

gsettings set org.cinnamon.desktop.keybindings.wm push-tile-up "['']"
gsettings set org.cinnamon.desktop.keybindings.wm push-tile-down "['']"
gsettings set org.cinnamon.desktop.keybindings.media-keys video-outputs "['XF86Display']"
gsettings set org.cinnamon.desktop.keybindings.media-keys screenshot "['']"

#--------------
#set keybinds
#--------------

#workspaces
#manually remove bindings in /usr/share/cinnamon/applets/grouped-window-list@cinnamon.org/applet.js in bindAppKey(i)
for i in {1..10}; do

	if [ $i -eq 10 ]; then
		gsettings set org.cinnamon.desktop.keybindings.wm switch-to-workspace-$i "['<Super>0']"
		gsettings set org.cinnamon.desktop.keybindings.wm move-to-workspace-$i "['<Super><Shift>0']"
	else
		gsettings set org.cinnamon.desktop.keybindings.wm switch-to-workspace-$i "['<Super>$i']"
		gsettings set org.cinnamon.desktop.keybindings.wm move-to-workspace-$i "['<Super><Shift>$i']"
	fi
done

#toggle fullscreen
gsettings set org.cinnamon.desktop.keybindings.wm toggle-maximized "['<Super>Up']"
#minimize window
gsettings set org.cinnamon.desktop.keybindings.wm minimize "['<Super>Down']"
#close window
gsettings set org.cinnamon.desktop.keybindings.wm close "['<Alt>F4', '<Super><Shift>q']"
#fullscreen
gsettings set org.cinnamon.desktop.keybindings.wm toggle-fullscreen "['<Super>f']"


#custom keybindings
let x=6
name0="terminal"
command0="kitty tmux"
binding0="['<Super>Return']"

name1="browser"
command1="firefox"
binding1="['<Super>p']"

name2="browser"
command2="firefox --private-window"
binding2="['<Super><Shift>p']"

name3="keepassxc"
command3="keepassxc"
binding3="['<Super>m']"

name4="filemanager"
command4="doublecmd"
binding4="['<Super>i']"

name5="editor"
command5="emacs"
binding5="['<Super>w']"

name6="screenshot-launch"
command6="gnome-screenshot -i"
binding6="['Print']"

for (( i = 0; i <= $x; i++  )); do
    if [ $i -eq $x ]; then
       customlist=$customlist"'custom$i'"
    else
       customlist=$customlist"'custom$i', "
    fi

    name=$(echo "name$i")
    command_a=$(echo "command$i")
    binding=$(echo "binding$i")

    gsettings set org.cinnamon.desktop.keybindings.custom-keybinding:/org/cinnamon/desktop/keybindings/custom-keybindings/custom$i/ name "${!name}"
    gsettings set org.cinnamon.desktop.keybindings.custom-keybinding:/org/cinnamon/desktop/keybindings/custom-keybindings/custom$i/ command "${!command_a}"
    gsettings set org.cinnamon.desktop.keybindings.custom-keybinding:/org/cinnamon/desktop/keybindings/custom-keybindings/custom$i/ binding "${!binding}"
done
gsettings set org.cinnamon.desktop.keybindings custom-list "[$customlist]"


#--------------
#set options
#--------------

#set workspaces to 10
gsettings set org.cinnamon.desktop.wm.preferences num-workspaces 10
