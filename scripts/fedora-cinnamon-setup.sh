#!/usr/bin/bash


install_packages(){
    #google-chrome
    curl https://dl.google.com/linux/linux_signing_key.pub > /tmp/chrome_key.pub
    rpm --import /tmp/chrome_key.pub
    cat <<EOF > /etc/yum.repos.d/google-chrome.repo
[google-chrome]
name=google-chrome
baseurl=http://dl.google.com/linux/chrome/rpm/stable/x86_64
gpgkey=https://dl.google.com/linux/linux_signing_key.pub
enabled=1
gpgcheck=1
skip_if_unavailable=1
EOF

    #vscode
    rpm --import https://packages.microsoft.com/keys/microsoft.asc
    cat <<EOF > /etc/yum.repos.d/vscode.repo
[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
enabled=1
skip_if_unavailable=1
EOF

    #doublecmd
    dnf -y config-manager --add-repo https://download.opensuse.org/repositories/home:Alexx2000/Fedora_31/home:Alexx2000.repo

    #rpm fusion
    dnf -y install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

    #update
    dnf -y upgrade

    #install packages
    dnf -y clang clang-tools-extra cmake code compat-ffmpeg28 dconf-editor doublecmd-gtk exfat-utils ffmpeg ffmpegthumbnailer fira-code-fonts flatpak fontawesome-fonts fuse-exfat \
    gimp git glances google-chrome-stable gstreamer1-libav gstreamer1-plugins-bad-freeworld gstreamer1-plugins-good-extras gstreamer1-plugins-ugly gstreamer-ffmpeg \
    htop keepassxc kitty mc mercurial meson mpv nasm papirus-icon-theme steam \
    syncthing VirtualBox vlc xclip z3-devel zsh
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    flatpak install -y --noninteractive discord spotify
}

copy_backup(){
    if [ -d "$1" ];then
        cp -r $1/. ~/
    else
        echo "$1 doesn't exist!"
        exit -1
    fi
}

build_emacs(){
    dnf builddep emacs
    git clone https://git.savannah.gnu.org/git/emacs.git /tmp/emacs-build
    GO_BACK_DIR=`pwd`
    cd /tmp/emacs-build
    ./autogen.sh
    ./configure
    make -j `nproc`
    make install -j `nproc`
    cd $GO_BACK_DIR
}

main(){
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi
}

main "$@"
