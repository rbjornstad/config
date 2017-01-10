#!/bin/zsh

# PATH
export PATH="/usr/local/share/python:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

# FileSearch
function f() { find . -iname "*$1*" ${@:2} }
function r() { grep "$1" ${@:2} -R . }

#mkdir and cd
function mkcd() { mkdir -p "$@" && cd "$_"; }

# Aliases
alias ll="ls -la"
alias lr="la -latr"
alias ws="cd ~/ws"
alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl -b"
alias pm="git push origin master"

# Use sublimetext for editing config files
alias envconf="subl ~/ws/conf/env.sh"
alias sconf="source ~/ws/conf/env.sh"
