# Global variables
export EDITOR="vim"

# PATH changes
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.luarocks/bin:$PATH"

# backup dir
export BACKUP_DIR="$HOME/src/config"
#ssh
#eval "$(ssh-agent)" &>/dev/null

#package manager aliases
if [ -f "/usr/bin/apt" ]; then
    # APT
    alias aptin='sudo apt install'
    alias aptrm='sudo apt remove'
    alias aptse='apt search'
    alias aptup='sudo apt update && sudo apt upgrade'
elif [ -f "/usr/bin/dnf" ]; then
    # DNF
    alias din='sudo dnf install'
    alias drm='sudo dnf remove'
    alias dse='dnf search'
    alias dup='sudo dnf upgrade --refresh'
elif [ -f "/usr/bin/pacman" ]; then
    # Pacman
    #alias pacman='pacman --color always'
fi

    
