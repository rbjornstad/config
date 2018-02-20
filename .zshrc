export PATH=/opt/idea/bin:/opt/Postman:/opt/cfssl:/opt/node/bin:/usr/local/go/bin:/opt/helm/linux-amd64:$PATH
# Path to your oh-my-zsh installation.
  export ZSH=~/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="avit"


# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=6'
plugins=(git kubectl zsh-autosuggestions )

source $ZSH/oh-my-zsh.sh
source ~/ws/kubeaware/kubeaware.sh

PROMPT='$(kubeaware_prompt)'$PROMPT

rdp() { xfreerdp -u RA_S138206 -d ADEO -g 1600x1000 --plugin cliprdr --plugin rdpdr --data disk:s138206:/home/S138206/lib/rdp -- "$@" ; }
#kc() { kubectl config use-context "$@"}
li() { cat ~/ws/nais-inventory/"$@" }
alias ku="kubeunaware"
alias ka="kubeaware"
alias uk="cd ~/ws/kubeconfigs; git pull origin master; cd -"
alias k="kubectl"
alias kc="~/ws/kubectx/kubectx"
alias kns="~/ws/kubectx/kubens"
alias ks="kubectl -n kube-system"
alias mm="rdp a01t9vw040.adeo.no"
alias ws="cd ~/ws"
alias sz="source ~/.zshrc"
alias ez="vi ~/.zshrc"
alias aura="ssh RA_S138206@a01apvl099.adeo.no"
alias nav="/opt/Citrix/ICAClient/wfica -icaroot /opt/Citrix/ICAClient /mnt/w/ica-filer/NAV\ Skrivebord\ Adeo.ica"
alias hipchat="HTTPS_PROXY= HTTP_PROXY= http_proxy= https_proxy= hipchat4"
alias pm="/opt/Postman/Postman &"
alias sql="/opt/sqldeveloper/sqldeveloper.sh"
