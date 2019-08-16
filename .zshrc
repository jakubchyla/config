# Path to your oh-my-zsh installation.
export ZSH="/home/jakchyla/.oh-my-zsh" # theme
export TERM="xterm-256color"
ZSH_THEME="powerlevel9k/powerlevel9k"
# powerlevel9k only options
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(user dir vcs newline)
POWERLEVEL9K_DISABLE_RPROMPT=true

plugins=(git zsh-completions)

source $ZSH/oh-my-zsh.sh &>/dev/null

#aliases
alias ls='ls --color'
alias la='ls -A'
alias ll='ls -Alh'
alias cls=clear
alias clls='clear && ls'
alias clla='clear && ls -A'
alias clll='clear && ls -Alh'
alias info='info --vi-keys'
alias vim="nvim"

alias tfbinds='vim ~/others/tf2/binds.txt'


#shell options
bindkey -v #enable vi


#source-highlight
#export LESSOPEN="| /usr/bin/source-highlight-esc.sh %s"
#export LESS='-R '

clear
