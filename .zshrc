export PATH=/usr/local/Cellar:/opt/idea/bin:/opt/Postman:/opt/cfssl:/opt/node/bin:/usr/local/opt/go/libexec/bin:/opt/helm/linux-amd64:$PATH
# Path to your oh-my-zsh installation.
  export ZSH=~/.oh-my-zsh

GO111MODULE=on

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="avit"

export KUBECONFIG=~/.kube/config
# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
export TERM=xterm-256color
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=6'
plugins=(git kubectl zsh-autosuggestions )

source $ZSH/oh-my-zsh.sh
source ~/ws/kubeaware/kubeaware.sh

PROMPT='$(kubeaware_prompt)'$PROMPT
EDITOR=/usr/bin/vim

# GO variables
GOROOT=/usr/local/Cellar/go/1.10/bin
GOPATH=~/ws/go
DEPPROJECTROOT=~/ws/go

cci_dev-gke() { curl --header "Content-Type: application/json" -d '{ "build_parameters": { "CLUSTER_NAME": "dev-gke", "GCP_PROJECT_NAME": "nais-dev-gke", "CLUSTER_CONTEXT_NAME": "gke_nais-dev-gke_europe-north1-a_dev-gke" }}' https://circleci.com/api/v1.1/project/github/nais/nais-gke?circle-token=2cd70276b1195cd192659867c604fd06ccdf4a9f }
cci_prod-gke() { curl --header "Content-Type: application/json" -d '{ "build_parameters": { "CLUSTER_NAME": "prod-gke",     "GCP_PROJECT_NAME": "nais-prod-gke", "CLUSTER_CONTEXT_NAME": "gke_nais-prod-gke_europe-north1-a_prod-gke" }}'      https://circleci.com/api/v1.1/project/github/nais/nais-gke?circle-token=2cd70276b1195cd192659867c604fd06ccdf4a9f }
WORKSPACE=~/ws
rdp() { xfreerdp -u RA_S138206 -d ADEO -g 1600x1000 --plugin cliprdr --plugin rdpdr --data disk:s138206:/home/S138206/lib/rdp -- "$@" ; }

li() { cat ~/ws/nais-inventory/"$@" }
alias ku="kubeunaware"
alias ka="kubeaware"
alias uk="cd ~/ws/kubeconfigs; git pull origin master; cd -"
alias k="kubectl"
alias kc="~/ws/kubectx/kubectx"
alias kns="~/ws/kubectx/kubens"
alias ks="kubectl -n kube-system"
alias ws="cd ~/ws"
alias mm="rdp a01t9vw040.adeo.no"
alias sz="source ~/.zshrc"
alias ez="vi ~/.zshrc"
alias aura="ssh RA_S138206@a01apvl099.adeo.no"
alias nav="/opt/Citrix/ICAClient/wfica -icaroot /opt/Citrix/ICAClient /mnt/w/ica-filer/NAV\ Skrivebord\ Adeo.ica"
alias hipchat="HTTPS_PROXY= HTTP_PROXY= http_proxy= https_proxy= hipchat4"
alias pm="/opt/Postman/Postman &"
alias sql="/opt/sqldeveloper/sqldeveloper.sh"
alias dev-dev="gcloud config set account frodesun@gmail.com && kc gke_nais-dev_europe-west1-b_nais-dev"
alias nais-dev="gcloud config set account frode.sundby@nav.no && kc gke_nais-dev-206213_europe-west1_nais-dev"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
