#
# ~/.bashrc
#

[ -f /etc/bashrc ] && source /etc/bash.bashrc
[ -f ~/.bashrc.functions ] && source ~/.bashrc.functions

PATH=/usr/local/bin:/usr/local/sbin/:/bin:/sbin:/usr/bin:/usr/sbin:/bin:/usr/bin:/sbin:/usr/sbin:/usr/local/bin:/usr/share/java/apache-ant/bin:/usr/bin/vendor_perl:/usr/bin/core_perl:/opt/qt/bin:$PATH
export PATH=${HOME}/.bin:$PATH


alias ls='ls --color=auto'
alias la='ls -a'
alias l='ls -la'
alias ll='ls -l'
#PS1='[\u@\h \W]\$ '
export PS1='\[\e[0;34m\]\u\[\e[m\] \[\e[1;35m\]\w\[\e[m\] \[\e[0;34m\]\[\e[0m\]$(parse_git_branch)\[\e[0;34m\]\$ \[\e[m\]\[\e[m\]'

alias cp='cp -i'
alias mv='mv -iv'
alias rm='rm -Iv'
alias di='di -f "m f 1" /media/* /home/kofish /'

export BROWSER='firefox'
export EDITOR='vim'
export GRAPHICAL='gvim'
export TERM='rxvt-unicode'
export COLORTERM='urxvt'
export EMAIL="Krister Svanlund <krister.svanlund@gmail.com>"

complete -cf sudo

export SDL_VIDEO_FULLSCREEN_HEAD=1

set bell-style visible
set expand-tilde on
set mark-directories on
set visible-stats on

set meta-flag on
set input-meta on

set convert-meta off
set output-meta on
set show-all-if-ambiguous on

shopt -s checkwinsize

export HISTCONTROL=ignoredups

eval `keychain -q --eval --agents ssh id_dsa`

if [ -f "/usr/lib/stderred.so" ]; then
  export LD_PRELOAD="/usr/lib/stderred.so"
fi

