#!/usr/bin/bash

install_packages(){
  #google-chrome
  if [ ! -f /etc/zypp/repos.d/google-chrome.repo ]; then
    curl https://dl.google.com/linux/linux_signing_key.pub > /tmp/chrome_key.pub
    rpm --import /tmp/chrome_key.pub
    printf '%s\n' \
    '[google-chrome]' \
    'name=google-chrome' \
    'baseurl=http://dl.google.com/linux/chrome/rpm/stable/x86_64' \
    'gpgkey=https://dl.google.com/linux/linux_signing_key.pub' \
    'enabled=1' \
    'gpgcheck=1' \
    'skip_if_unavailable=1' > /etc/zypp/repos.d/google-chrome.repo
  fi
  if [ ! -f /etc/zypp/repos.d/vscode.repo ]; then
    #vscode
    rpm --import https://packages.microsoft.com/keys/microsoft.asc
    printf '%s\n' \
    '[code]' \
    'name=Visual Studio Code' \
    'baseurl=https://packages.microsoft.com/yumrepos/vscode' \
    'gpgcheck=1' \
    'gpgkey=https://packages.microsoft.com/keys/microsoft.asc' \
    'enabled=1' \
    'skip_if_unavailable=1' > /etc/zypp/repos.d/vscode.repo
  fi

  #update
  zypper dup -y

  #install packages
  zypper install -y ccls clang clang-tools-extra cmake code \
    exfat-utils ffmpeg ffmpegthumbnailer \
    flatpak gimp git glances google-chrome-stable \
    htop keepassxc kitty mc meson mpv nasm neovim npm papirus-icon-theme \
    steam syncthing vlc xclip zsh

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


main(){
  if [[ $EUID -ne 0 ]]; then
    echo "This script must be run with sudo"
    exit 1
  fi

  while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
      --all)
        CINNAMON_SCRIPT="./scripts/cinnamon-settings.sh"
        PACKAGES="SET"
        EMACS_BUILD="SET"
        BACKUP_SCRIPT="./backup.sh"
        shift
        break
      ;;
      --cinnamon)
        CINNAMON_SCRIPT="$2"
        shift
        shift
      ;;
      --xfce)
        XFCE_SCRIPT="$2"
        shift
        shift
      ;;
      --packages)
        PACKAGES="SET"
        shift
      ;;
      --build-emacs)
        EMACS_BUILD="SET"
        shift
      ;;
      --backup)
        BACKUP_SCRIPT="$2"
        shift
        shift
      ;;
      --basic)
        PACKAGES="SET"
        REST="SET"
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

  if [ ! -z "$EMACS_BUILD" ]; then
    build_emacs
  fi

  if [ ! -z "$REST" ]; then
    rest
  fi

  if [[ -f "$BACKUP_SCRIPT" && ! -z "$BACKUP_SCRIPT" ]];then
    sudo -H -u $SUDO_USER ./$BACKUP_SCRIPT --pull
  elif [ ! -z "$BACKUP_SCRIPT" ]; then
    echo "$BACKUP_SCRIPT doesn't exist!"
  fi

  if [[ -f "$CINNAMON_SCRIPT" && ! -z "$CINNAMON_SCRIPT" ]]; then
    if [ -z $SUDO_USER ]; then
      echo "\$SUDO_USER not set, skipping"
    else
      ./$CINNAMON_SCRIPT
    fi
  elif [ ! -z "$CINNAMON_SCRIPT" ]; then
    echo "$CINNAMON_SCRIPT doesn't exist!"
  fi

  if [[ -f "$XFCE_SCRIPT" && ! -z "$XFCE_SCRIPT" ]]; then
    if [ -z $SUDO_USER ]; then
      echo "\$SUDO_USER not set, skipping"
    else
      ./$XFCE_SCRIPT
    fi
  elif [ ! -z "$XFCE_SCRIPT" ]; then
    echo "$XFCE_SCRIPT doesn't exist!"
  fi
}

main "$@"
