# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#aliases
alias ls='ls --color'
#alias ll='ls -Alh'
#alias la='ls -A'
#alias l='ls -Alh'
alias info='info --vi-keys'
alias sup='shutdown now'
alias rm='rm --interactive'
alias pless='ps aux | less'
alias pacman='pacman --color always'
alias less='less -R'
alias vim='nvim'
alias gvim='nvim-qt 2>/dev/null'
#alias din='sudo dnf install'
#alias drm='sudo dnf remove'
#alias dse='dnf search'
#alias dup='sudo dnf upgrade --refresh'


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

DISABLE_MAGIC_FUNCTIONS=true

#aliases
alias ls='ls --color'
#alias ll='ls -Alh'
#alias la='ls -A'
#alias l='ls -Alh'
alias info='info --vi-keys'
alias sup='shutdown now'
alias rm='rm --interactive'
alias pless='ps aux | less'
alias pacman='pacman --color always'
#alias din='sudo dnf install'
#alias drm='sudo dnf remove'
#alias dse='dnf search'
#alias dup='sudo dnf upgrade --refresh'

export POS='jakchyla@192.168.0.185'


#shell options
bindkey -v #enable vi

#source-highlight
export LESSOPEN="| /usr/bin/source-highlight-esc.sh %s"

#kitty completion
autoload -Uz compinit
compinit
kitty + complete setup zsh | source /dev/stdin

#clear
