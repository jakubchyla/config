# vim:foldmethod=marker

# oh-my-zsh {{{
    # Path to your oh-my-zsh installation.
    export ZSH="$HOME/.oh-my-zsh"
    export TERM="xterm-256color"
    ZSH_THEME="powerlevel10k/powerlevel10k"

    source $ZSH/oh-my-zsh.sh &>/dev/null
    # messes up copy-paste
    DISABLE_MAGIC_FUNCTIONS=true

    # zsh options
    #enable vi
    bindkey -v
    #how long to wait for next char (affects vim mode)
    KEYTIMEOUT=1 

# }}}

# powerlevel10k {{{
    [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

    plugins=( common-aliases zsh-syntax-highlight zsh-autosuggestions zsh-completions  )
    autoload -U compinit && compinit 

# Enable Powerlevel10k instant prompt
    if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
        source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
    fi

#}}}

#aliases {{{
    alias ls='ls --color'
    alias info='info --vi-keys'
    alias sup='/sbin/shutdown now'
    alias rm='rm --interactive'
    alias pless='ps aux | less'
    alias less='less -R'
    alias vim='nvim'
    alias glances='glances --disable-bg'
    alias unsshfs='fusermount3 -u'
    emacs () {/usr/local/bin/emacs $@ &}
    alias -g C="| xclip -selection \"clipboard\""

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
        alias pacman='pacman --color always'
    fi

#}}}

# ~/.zfunc {{{
    fpath+=~/.zfunc
    compinit

#}}}

# rest {{{
    #source-highlight
    export LESSOPEN="| /usr/bin/source-highlight-esc.sh %s" 

    #trackball {{{
        trackball(){
            id=`xinput --list --short | grep "Kensington USB Orbit" | grep -Po "id=\d*" | grep -Po "\d*"`
            if [ $id ]; then
                prop_id=`xinput list-props $id | grep -Po "Middle Emulation Enabled \(\d*\)" | grep -Po "\d*"`
                xinput set-prop $id $prop_id 1
            fi
        }
        trackball
    #}}}
    
#}}}

clear
