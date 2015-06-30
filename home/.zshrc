# Lines configured by zsh-newuser-install
HISTFILE=~/.zhistfile
HISTSIZE=100000
SAVEHIST=1000
setopt appendhistory extendedglob notify
unsetopt autocd
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/kofish/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

alias vim=`which nvim`
