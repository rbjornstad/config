export PATH=/usr/local/opt/openjdk/bin:/usr/local/Cellar:/usr/local/go/bin:~/go/bin:/opt/node/bin::~/opt/bin:~/opt/kubebuilder_2.3.1_darwin_amd64/bin:$HOME/.krew/bin:$PATH
export CPPFLAGS="-I/usr/local/opt/openjdk/include"
KUBENCS_BINARY=/usr/local/bin/kubens

export VAULT_ADDR=https://vault.adeo.no

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh
export LANG=en_US.UTF-8

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="avit"


# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
export TERM=xterm-256color
plugins=(git kubectl )

source $ZSH/oh-my-zsh.sh

# GO variables
GOROOT=/usr/local/Cellar/go/1.10/bin
GOPATH=~/go
GO111MODULE=on
DEPPROJECTROOT=~/ws/go

#VI mode
EDITOR=/usr/bin/vim
VISUAL=/usr/bin/vim
bindkey -v

autoload -z edit-command-line
zle -N edit-command-line

bindkey '^w' backward-kill-word
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey -M vicmd 'v' edit-command-line

WORKSPACE=~/ws
rdp() { xfreerdp -u RA_S138206 -d ADEO -g 1600x1000 --plugin cliprdr --plugin rdpdr --data disk:s138206:/home/S138206/lib/rdp -- "$@" ; }
kubens_fzf() {
    ${KUBENS_BINARY} $(${KUBENS_BINARY} | fzf -1 --ansi -q ${1:-""})
    tmux refresh-client -S
}

li() { cat ~/ws/nais-inventory/"$@" }
alias unifi="ssh svadapi.ddns.net -p 4242 -L 8443:unifi:8443"
alias uk="cd ~/ws/kubeconfigs; git pull origin master; cd -"
alias temp="cd ~/ws/temp"
alias k="kubectl $@"
alias kc="kubectx"
alias kns=kubens
#alias kns="kubens_fzf $@"
alias ks="kubectl -n kube-system"
alias ws="cd ~/ws"
alias mm="rdp a01t9vw040.adeo.no"
alias sz="source ~/.zshrc"
alias ez="vi ~/.zshrc"
alias aura="ssh RA_S138206@a01apvl099.adeo.no"
alias nav="/opt/Citrix/ICAClient/wfica -icaroot /opt/Citrix/ICAClient /mnt/w/ica-filer/NAV\ Skrivebord\ Adeo.ica"
alias dev-dev="gcloud config set account frodesun@gmail.com && kc gke_nais-dev_europe-west1-b_nais-dev"
alias nais-dev="gcloud config set account frode.sundby@nav.no && kc gke_nais-dev-206213_europe-west1_nais-dev"
alias gilo='git log --all --decorate --oneline --graph'
alias gcfs='gcloud config set account frode.sundby@nav.no'
alias gctf='gcloud config set account terraform-ci-user@terraform-234613.iam.gserviceaccount.com'
alias gcgv='gcloud config get-value account'
alias tmux='tmux -u'
alias rg='rg --hidden'
alias rgf='rg  --files | rg'
alias idea='open -na "IntelliJ IDEA" --args .'
alias myip='curl https://icanhazip.com/s 2>/dev/null'
alias wl='watch kubectl logs $1 $2'
alias github='open_github_for_current_folder'
alias gcp='gcloud_set_project_fzf'
alias glo='gcloud auth login --update-adc'

open_github_for_current_folder () {
    open $(git remote get-url --all origin)
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/frodesundby/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/frodesundby/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/frodesundby/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/frodesundby/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/vault vault

gcloud_set_project_fzf () {
    gcloud config set project $(gcloud projects list --format="get(projectId)" | fzf -1 --ansi -q ${1:-""}); 
    tmux refresh-client -S
}
