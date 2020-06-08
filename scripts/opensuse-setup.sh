#!/usr/bin/bash

install_packages(){
  #google-chrome
  if [ ! -f /etc/zypp/repos.d/google-chrome.repo ]; then
    echo "adding google-chrome repo"
    curl https://dl.google.com/linux/linux_signing_key.pub > /tmp/chrome_key.pub
    sudo rpm --import /tmp/chrome_key.pub
    sudo printf '%s\n' \
    '[google-chrome]' \
    'name=google-chrome' \
    'baseurl=http://dl.google.com/linux/chrome/rpm/stable/x86_64' \
    'gpgkey=https://dl.google.com/linux/linux_signing_key.pub' \
    'enabled=1' \
    'gpgcheck=1' \
    'skip_if_unavailable=1' > /etc/zypp/repos.d/google-chrome.repo
  fi
  #vscode
  if [ ! -f /etc/zypp/repos.d/vscode.repo ]; then
    echo "adding vscode repo"
    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    sudo printf '%s\n' \
    '[code]' \
    'name=Visual Studio Code' \
    'baseurl=https://packages.microsoft.com/yumrepos/vscode' \
    'gpgcheck=1' \
    'gpgkey=https://packages.microsoft.com/keys/microsoft.asc' \
    'enabled=1' \
    'skip_if_unavailable=1' > /etc/zypp/repos.d/vscode.repo
  fi

  #update
  echo "updating"
  sudo zypper dup -y

  #install packages
  PACKAGE_LIST1="bat clang cmake code flatpak gimp git glances \
    google-chrome-stable htop keepassxc kitty mc meson mpv nasm neovim \
    papirus-icon-theme steam syncthing xclip xinput zsh"
  PACKAGE_LIST2="ffmpeg-4 vlc"

  echo "installing packages"
  sudo zypper install -y $PACKAGE_LIST1
  sudo zypper install -y --allow-vendor-change --from packman $PACKAGE_LIST2

  echo "installing flatpaks"
  flatpak --user remote-add --if-not-exists flathub \
    https://flathub.org/repo/flathub.flatpakrepo
  flatpak --user install -y --noninteractive com.spotify.Client com.discordapp.Discord
  if ! [ -z $SUDO_USER ]; then
    flatpak --user override --filesystem=$HOME/Music com.spotify.Client
    flatpak --user override --filesystem=$HOME/Pictures com.discordapp.Discord
  fi
 #oh-my-zsh
 echo "installing oh-my-zsh"
 sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
 git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
}




main(){
  while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
      --packages)
        PACKAGES="SET"
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

  if [ ! -z "$PACKAGES" ]; then
    install_packages
  fi
}

main "$@"
