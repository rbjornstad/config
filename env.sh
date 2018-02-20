#!/bin/zsh

## Theme set in ~/.zshrc

# PLUGINS
plugins=(git colored-man colorize github vagrant virtualenv brew osx zsh-syntax-highlighting zsh-autosuggestions)
source <(kubectl completion zsh)

# PATH
export PATH="/usr/local/share/python:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Users/frodesundby/lib"

#GOPATH
export GOPATH=~/ws/go
# FileSearch
function f() { find . -iname "*$1*" ${@:2} }
function r() { grep "$1" ${@:2} -R . }

#mkdir and cd
function mkcd() { mkdir -p "$@" && cd "$_"; }

# Aliases
alias ll="ls -la"
alias lr="la -latr"
alias ws="cd ~/ws"
alias gs="cd ~/ws/go/src"
alias subl="/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl -b"
alias pm="git push origin master"

# Use sublimetext for editing config files
alias ez="vi ~/ws/conf/env.sh"
alias sz="source ~/ws/conf/env.sh"

# Kubernetes aliases
alias k=kubectl
alias ks="kubectl -n kube-system"
