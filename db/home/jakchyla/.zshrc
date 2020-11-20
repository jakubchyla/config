# vim:foldmethod=marker

# oh-my-zsh {{{

    # Path to your oh-my-zsh installation.
    export ZSH="$HOME/.oh-my-zsh"
    export TERM="xterm-256color"
    ZSH_THEME="halla"

    plugins=(jump cargo rustup docker docker-compose)

    source $ZSH/oh-my-zsh.sh 

# }}}

#aliases {{{
    alias _='sudo'
    alias __='sudo su'
    alias ls='ls --color=always'
    alias sup='/sbin/shutdown now'
    alias rm='rm --interactive'
    alias pless='ps aux | less'
    alias less='less -R'

    alias notifend='notify-send --hint=string:desktop-entry:kitty -i dialog-information -t 10'

    if [ -f "/usr/bin/nvim" ]; then
        alias vim='nvim'
    fi
    if [ -f "/usr/bin/glances" ]; then
        alias glances='glances --disable-bg'
    fi
    if [ -f "/usr/bin/fusermount3" ]; then
        alias unsshfs='fusermount3 -u'
    fi
    if [ -f "/usr/bin/unbuffer" ]; then
        cless () {unbuffer $@ | /usr/bin/less}
    fi
    if [ -f "/usr/bin/emacs" ]; then
        emacs () {$HOME/bin/emacs $@ &>/dev/null &}
    fi
    

    # pipe {{{
    alias -g C="| xclip -selection \"clipboard\""
    alias -g G="| grep"
    alias -g L="| less"
    #}}}

    # vagrant {{{
    if [ -f "/usr/bin/vagrant" ]; then
        alias vagup='vagrant up'
        alias vagdown='vagrant halt'
        alias vagssh='vagrant ssh'
        alias vagsnap-push='vagrant snapshot push'
        alias vagsnap-pop='vagrant snapshot pop'
    fi
    #}}}

    # package manager {{{
    
    # dnf {{{
    PACIN="sudo dnf install"
    PACRM="sudo dnf remove"
    PACSE="dnf search"
    PACUP="sudo dnf upgrade"
    #}}}

    # apt {{{
    #PACIN='sudo apt install'
    #PACRM='sudo apt remove'
    #PACSE='apt search'
    #PACUP='sudo apt update && sudo apt upgrade'
    #}}}
    
    # pacman {{{
    #PACIN='sudo pacman -S'
    #PACRM='sudo pacman -Rs'
    #PACSE='pacman -Ss'
    #PACUP='sudo pacman -Syu'
    #}}}
    
    # zypper (tumbleweed) {{{
    #PACIN='sudo zypper install'
    #PACRM='sudo zypper remove -u'
    #PACSE='zypper search'
    #PACUP='sudo zypper dup --allow-vendor-change'
    #}}}
    
    alias pacin="$PACIN"
    alias pacrm="$PACRM"
    alias pacse="$PACSE"
    alias pacup="$PACUP"

    # flatpak aliases {{{
    alias flatin='sudo flatpak install'
    alias flatrm='sudo flatpak uninstall'
    alias flatup='sudo flatpak update'
    #}}}

    #}}}

#}}}

# ~/.zfunc {{{
    # added completion with plugins
    #fpath+=~/.zfunc
    #compinit

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
        #trackball
    #}}}

    # systemd completion workaround {{{
      _systemctl_unit_state() {
          typeset -gA _sys_unit_state
          _sys_unit_state=( $(__systemctl list-unit-files "$PREFIX*" | awk '{print $1, $2}') )
      }
    #}}}
    
#}}}

clear
