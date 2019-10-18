#! /bin/bash

#--------------
#remove conflicting keybinds
#--------------
for i in {1..9}; do
	gsettings set org.gnome.shell.keybindings switch-to-application-$i "['']"
done


gsettings set org.gnome.mutter.keybindings switch-monitor "['XF86Display']"
gsettings set org.gnome.shell.keybindings toggle-message-tray "['<Super>v']"


#--------------
#set keybinds
#--------------

#workspaces
for i in {1..10}; do

	if [ $i -eq 10 ]; then
		gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-$i "['<Super>0']"
		gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-$i "['<Super><Shift>0']"
	else
		gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-$i "['<Super>$i']"
		gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-$i "['<Super><Shift>$i']"
	fi
done

#close window
gsettings set org.gnome.desktop.wm.keybindings close "['<Alt>F4', '<Super><Shift>q']"
#fullscreen
gsettings set org.gnome.desktop.wm.keybindings toggle-fullscreen "['<Super>f']"


#--------------
#set options
#--------------

#change apps on current workspace
gsettings set org.gnome.shell.app-switcher current-workspace-only true
