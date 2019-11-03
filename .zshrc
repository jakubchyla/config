# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh" # theme
export TERM="xterm-256color"
ZSH_THEME="gentoo"

# oh-my-zsh
source $ZSH/oh-my-zsh.sh &>/dev/null
# fish-like syntax highlighting
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


DISABLE_MAGIC_FUNCTIONS=true

# If not running interactively, do not do anything
[[ $- != *i* ]] && return
[[ -z "$TMUX" ]] && exec tmux

#aliases
alias ls='ls --color'
alias la='ls -A'
alias ll='ls -Alh'
alias l='ls -Alh'
alias cls='clear'
alias clls='clear && ls'
alias clla='clear && ls -A'
alias clll='clear && ls -Alh'
alias info='info --vi-keys'

#shell options
bindkey -v #enable vi

#source-highlight
export LESSOPEN="| /usr/bin/source-highlight-esc.sh %s"

#kitty completion
autoload -Uz compinit
compinit
kitty + complete setup zsh | source /dev/stdin

clear
