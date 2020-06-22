#!/usr/bin/bash

# vim:foldmethod=marker

#google-chrome {{{
google_chrome(){
    if [ ! -f /etc/yum.repos.d/google-chrome.repo ]; then
        curl https://dl.google.com/linux/linux_signing_key.pub > /tmp/chrome_key.pub
        rpm --import /tmp/chrome_key.pub
        printf '%s\n' \
        '[google-chrome]' \
        'name=google-chrome' \
        'baseurl=http://dl.google.com/linux/chrome/rpm/stable/x86_64' \
        'gpgkey=https://dl.google.com/linux/linux_signing_key.pub' \
        'enabled=1' \
        'gpgcheck=1' \
        'skip_if_unavailable=1' > /etc/yum.repos.d/google-chrome.repo
    fi
    dnf -y install google-chrome
}
#}}}

#vscode {{{
vscode(){
    if [ ! -f /etc/yum.repos.d/vscode.repo ]; then
        #vscode
        rpm --import https://packages.microsoft.com/keys/microsoft.asc
        printf '%s\n' \
        '[code]' \
        'name=Visual Studio Code' \
        'baseurl=https://packages.microsoft.com/yumrepos/vscode' \
        'gpgcheck=1' \
        'gpgkey=https://packages.microsoft.com/keys/microsoft.asc' \
        'enabled=1' \
        'skip_if_unavailable=1' > /etc/yum.repos.d/vscode.repo
    fi
    dnf -y install code
}
#}}}

#setup {{{
setup(){
    #doublecmd
    dnf -y config-manager --add-repo \
        https://download.opensuse.org/repositories/home:Alexx2000/Fedora_31/home:Alexx2000.repo

    #rpm fusion
    dnf -y install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
        https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

    #update
    dnf -y upgrade

    #install packages
    dnf -y install ccls clang clang-tools-extra cmake\
        doublecmd-gtk exfat-utils ffmpeg ffmpegthumbnailer fira-code-fonts \
        flatpak fontawesome-fonts fuse-exfat gimp git glances \
        htop keepassxc kitty mc meson mpv nasm neovim npm papirus-icon-theme \
        steam syncthing vagrant virt-manager VirtualBox vlc xclip zsh

    flatpak remote-add --if-not-exists flathub \
        https://flathub.org/repo/flathub.flatpakrepo
    flatpak install -y --noninteractive com.spotify.Client com.discordapp.Discord
    if ! [ -z $SUDO_USER ]; then
        flatpak override --filesystem=/home/$SUDO_USER/Music com.spotify.Client
        flatpak override --filesystem=/home/$SUDO_USER/Pictures com.discordapp.Discord
    fi

    #oh-my-zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
}
#}}}

#main {{{
main(){
    if [[ $EUID -ne 0 ]]; then
        echo "This script must be run with sudo"
        exit 1
    fi

    while [[ $# -gt 0 ]]; do
        key="$1"
        case $key in
            --setup)
                SETUP="SET"
                GOOGLE_CHROME="SET"
                VSCODE="SET"
                shift
            ;;
            --google-chrome)
                GOOGLE_CHROME="SET"
                shift
            ;;
            --vscode)
                VSCODE="SET"
                shift
            ;;
            *)
                POSITIONAL+="$1 "
                shift
            ;;
        esac
    done
    if [ ! -z $POSITIONAL ]; then
        echo "Unknown options: $POSITIONAL"
        exit 1
    fi

    if [ ! -z "$SETUP" ]; then
            setup
    fi

    if [ ! -z "$GOOGLE_CHROME" ]; then
        google_chrome
    fi

    if [ ! -z "$VSCODE" ]; then
        vscode
    fi
}
#}}}

main "$@"
