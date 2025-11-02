#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto -Av'
alias grep='grep --color=auto -n'
alias vim='nvim'

UID_COLOR='\e[0;36m'
TTY=$(tty)
TTY=${TTY#/dev/}

PS1="\n\A \[${UID_COLOR}\]\u\[\e[90m\]@${TTY}:\h \[\e[94m\]\w \[${UID_COLOR}\]\\$\[\e[m\] "

# Quick fix to override font problems
if [[ ${TERM} == 'linux' ]]; then
    setfont -d cyr-sun16
fi
