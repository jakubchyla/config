# vim:foldmethod=marker

# oh-my-zsh {{{
    # Path to your oh-my-zsh installation.
    export ZSH="$HOME/.oh-my-zsh"
    export TERM="xterm-256color"
    ZSH_THEME="halla"

    source $ZSH/oh-my-zsh.sh &>/dev/null

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
    alias ls='ls --color=never'
    alias info='info --vi-keys'
    alias sup='/sbin/shutdown now'
    alias rm='rm --interactive'
    alias pless='ps aux | less'
    alias less='less -R'
    alias vim='nvim'
    alias glances='glances --disable-bg'
    alias unsshfs='fusermount3 -u'
    cless () {unbuffer $@ | /usr/bin/less}
    emacs () {$HOME/bin/emacs $@ &>/dev/null &}
    
    # vagrant
    alias vagup='vagrant up'
    alias vagdown='vagrant halt'
    alias vagssh='vagrant ssh'
    alias vagsnap-push='vagrant snapshot push'
    alias vagsnap-pop='vagrant snapshot pop'

    # pipe aliases
    alias -g C="| xclip -selection \"clipboard\""
    alias -g G="| grep"
    alias -g L="| less"
    alias -g B="| bat"

    # package manager aliases
    if [ -f "/usr/bin/apt" ]; then
        # apt
        alias pacin='sudo apt install'
        alias pacrm='sudo apt remove'
        alias pacse='apt search'
        alias pacup='sudo apt update && sudo apt upgrade'
    elif [ -f "/usr/bin/dnf" ]; then
        # dnf
        alias pacin='sudo dnf install'
        alias pacrm='sudo dnf remove'
        alias pacse='dnf search'
        alias pacup='sudo dnf upgrade'
    elif [ -f "/usr/bin/pacman" ]; then
        # pacman
        alias pacin='sudo pacman -S'
        alias pacrm='sudo pacman -Rs'
        alias pacse='pacman -Ss'
        alias pacup='sudo pacman -Syu'
    elif [ -f "/usr/bin/zypper" ]; then
        # zypper
        alias pacin='sudo zypper install'
        alias pacrm='sudo zypper remove -u'
        alias pacse='zypper search'
        alias pacup='sudo zypper dup --allow-vendor-change'
    fi
    # flatpak aliases
    alias flatin='sudo flatpak install'
    alias flatrm='sudo flatpak uninstall'
    alias flatup='sudo flatpak update'

#}}}

# ~/.zfunc {{{
    fpath+=~/.zfunc
    compinit

#}}}

# zsh options {{{
    # enable vi
    bindkey -v
    # how long to wait for next char (affects vim mode)
    KEYTIMEOUT=1 
    # messes up copy-paste
    DISABLE_MAGIC_FUNCTIONS=true
    # history size
    export HISTSIZE=1000000

# }}}

# rest {{{
    # source-highlight
    export LESSOPEN="| /usr/bin/source-highlight-esc.sh %s" 

    # trackball {{{
        trackball(){
            id=`xinput --list --short 2>/dev/null | grep "Kensington USB Orbit" | grep -Po "id=\d*" | grep -Po "\d*"`
            if [ $id ]; then
                prop_id1=`xinput list-props $id 2>/dev/null | grep -Po "Middle Emulation Enabled \(\d*\)" | grep -Po "\d*"`
                prop_id2=`xinput list-props $id 2>/dev/null | grep -Po "Button Scrolling Button \(\d*\)" | grep -Po "\d*"`
                xinput set-prop $id $prop_id1 1 2>/dev/null
                xinput set-prop $id $prop_id2 3 2>/dev/null
            fi
        }
        trackball
    #}}}

    # systemd completion workaround {{{
      _systemctl_unit_state() {
          typeset -gA _sys_unit_state
          _sys_unit_state=( $(__systemctl list-unit-files "$PREFIX*" | awk '{print $1, $2}') )
      }
    #}}}
    
#}}}

clear
