# Enable Powerlevel10k instant prompt
    if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
      source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
    fi

#aliases
    alias ls='ls --color'
    alias info='info --vi-keys'
    alias sup='shutdown now'
    alias rm='rm --interactive'
    alias pless='ps aux | less'
    alias less='less -R'
    alias vim='nvim'
    alias glances='glances --disable-bg'
    alias unsshfs='fusermount3 -u'
    emacs () {/usr/local/bin/emacs $@ &}

    # Arch
    #alias pacman='pacman --color always'

    # Fedora
    alias din='sudo dnf install'
    alias drm='sudo dnf remove'
    alias dse='dnf search'
    alias dup='sudo dnf upgrade --refresh'
    

# Path to your oh-my-zsh installation.
    export ZSH="$HOME/.oh-my-zsh" # theme
    export TERM="xterm-256color"
    ZSH_THEME="powerlevel10k/powerlevel10k"


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
    [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

    plugins=( common-aliases zsh-syntax-highlight zsh-autosuggestions zsh-completions  )
    autoload -U compinit && compinit


# oh-my-zsh
    source $ZSH/oh-my-zsh.sh &>/dev/null
    # messes up copy-paste
    DISABLE_MAGIC_FUNCTIONS=true


# zsh options
    #enable vi
    bindkey -v
    #how long to wait for next char (affects vim mode)
    KEYTIMEOUT=1 


#source-highlight
    export LESSOPEN="| /usr/bin/source-highlight-esc.sh %s"


clear
