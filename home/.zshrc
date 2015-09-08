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

session-vim() {
	if [ -f "Session.vim" ]; then
		`which nvim` -S Session.vim
	else
		`which nvim` -c ":Obsession"
	fi
}

alias svim=session-vim

autoload edit-command-line; zle -N edit-command-line
bindkey "^X^E" edit-command-line

tig-status() {
	BUFFER="tig status"
	zle accept-line
}

zle -N tig-status

bindkey "^Gs" tig-status

## Helper functions
###################
cdResetPrompt() { zle reset-prompt; echo; ls; echo; }
cdPushKey() { pushd "$1" > /dev/null; cdResetPrompt; }
cdPopKey() { popd > /dev/null; popd > /dev/null; cdResetPrompt; }

## Keybinding functions
#######################

cdUndoKey() { cdPopKey; }
zle -N cdUndoKey
bindkey '^[[1;3D' cdUndoKey

cdParentKey() { cdPushKey ".."; }
zle -N cdParentKey
bindkey '^[[1;3A' cdParentKey

cdHomeKey() { cdPushKey "$HOME"; }
zle -N cdHomeKey
bindkey '^[[1;3B' cdHomeKey
