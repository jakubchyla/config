#!/usr/bin/env bash


install_packages(){
#google-chrome
curl https://dl.google.com/linux/linux_signing_key.pub > /tmp/chrome_key.pub
sudo rpm --import /tmp/chrome_key.pub
sudo sh -c 'echo -e "[google-chrome]\nname=google-chrome\nbaseurl=http://dl.google.com/linux/chrome/rpm/stable/x86_64\ngpgkey=https://dl.google.com/linux/linux_signing_key.pub\nenabled=1\ngpgcheck=1\nskip_if_unavailable=1" > /etc/yum.repos.d/google-chrome.repo'
rm /tmp/chrome_key.pub

#vscode
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'

#doublecmd
sudo dnf -y config-manager --add-repo https://download.opensuse.org/repositories/home:Alexx2000/Fedora_31/home:Alexx2000.repo

#rpm fusion
sudo dnf -y install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

#update
sudo dnf -y upgrade

#install packages
sudo dnf -y autoconf clang clang-tools-extra cmake code compat-ffmpeg28 dconf-editor doublecmd-gtk exfat-utils ffmpeg ffmpegthumbnailer fira-code-fonts flatpak fontawesome-fonts fuse-exfat giflib-devel gimp git glances gnutls-devel google-chrome gstreamer1-libav gstreamer1-plugins-bad-freeworld gstreamer1-plugins-good-extras gstreamer1-plugins-ugly gstreamer-ffmpeg gtk2-devel gtk4-devel gtk+-devel htop keepassxc kitty libjpeg-turbo-devel libXaw-devel mc mercurial meson mpv nasm ncurses-devel openssl-devel papirus-icon-theme SDL-devel steam syncthing texinfo VirtualBox vlc xclip z3-devel zsh
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
sudo flatpak install -y --noninteractive discord spotify
}


cinnamon_setup(){
#--------------
#remove conflicting keybinds
#--------------

gsettings set org.cinnamon.desktop.keybindings.wm push-tile-up "['']"
gsettings set org.cinnamon.desktop.keybindings.wm push-tile-down "['']"

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
let x=5

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

for i in {0..$x}; do
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
}

copy_backup(){
    if [ -d "$1" ];then
        cp -r $1/. ~/
    else
        echo "$1 doesn't exist!"
        exit -1
    fi
}
