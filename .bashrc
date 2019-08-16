# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

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

