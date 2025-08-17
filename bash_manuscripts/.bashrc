#
# ~/.bashrc
#

# ACYL_BLACK=0
# BLACK     30
# RED       31
# GREEN     32
# YELLOW    33
# BLUE      34
# PINK      35
# CYAN      36
# WHITE     37

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto -Av'
alias grep='grep --color=auto -n'

alias vim='nvim'

PS1='\n\A \[\e[36m\]\u\[\e[90m\]@\h \[\e[94m\]\w \[\e[0;36m\]\$\[\e[m\] '

# Change cursor style (white non-blinking full block)
# echo -e '\e[?112c'

# Quick fix to override font problems
if [[ ${TERM} == "linux" ]]; then
    setfont -d cyr-sun16
fi
