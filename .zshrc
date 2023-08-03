# Exports
export path=(
/usr/local/bin
/usr/local/Cellar
/opt/node/bin
~/go/bin
~/opt/bin
~/opt/kubebuilder_2.3.1_darwin_amd64/bin
~/.krew/bin
$path
)

export USE_GKE_GCLOUD_AUTH_PLUGIN=True


# CDPATH
export CDPATH=.:..:~/workspace

export CPPFLAGS="-I/usr/local/opt/openjdk/include"
export VAULT_ADDR=https://vault.adeo.no
export GPG_TTY=$(tty)

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

# Aliases
alias grw="gh run watch"
alias ndl="k logs -n nais-system -l app.kubernetes.io/instance=naisd"
alias t="tenant_fzf"
alias reset_onprem_kube_token="yq eval -i 'del(.users[] | select(.name == \"nais-user\") | .user.auth-provider.config.access-token)' ~/ws/kubeconfigs/config"
alias unifi="ssh svadapi.ddns.net -p 4242 -L 8443:unifi:8443"
alias uk="cd ~/ws/kubeconfigs; git pull origin master; cd -"
alias temp="cd ~/ws/temp"
alias k="kubectl $@"
alias kc="kubectx"
alias kns=kubens
alias ks="kubectl -n kube-system"
alias ws="cd ~/ws"
alias mm="rdp a01t9vw040.adeo.no"
alias sz="source ~/.zshrc"
alias ez="vi ~/.zshrc"
alias aura="ssh RA_S138206@a01apvl099.adeo.no"
alias nav="/opt/Citrix/ICAClient/wfica -icaroot /opt/Citrix/ICAClient /mnt/w/ica-filer/NAV\ Skrivebord\ Adeo.ica"
#alias dev-dev="gcloud config set account frodesun@gmail.com && kc gke_nais-dev_europe-west1-b_nais-dev"
#alias nais-dev="gcloud config set account frode.sundby@nav.no && kc gke_nais-dev-206213_europe-west1_nais-dev"
alias gilo='git log --all --decorate --oneline --graph'
alias gcsu='gcloud config set account $(gcloud auth list --format="value(account)" | fzf)'
alias tmux='tmux -u'
alias rg='rg --hidden'
alias rgf='rg  --files | rg'
#alias idea='open -na "IntelliJ IDEA" --args .'
alias idea='code .'
alias myip='curl https://icanhazip.com/s 2>/dev/null'
alias wl='watch kubectl logs $1 $2'
alias github='gh repo view --web'
alias gcp='gcloud_set_project_fzf'
alias glo='gcloud auth login --update-adc'
alias xgcloud='gcloud_command_with_project_fzf'
alias check='check_adhoc'
alias stripx='sudo xattr -d -r com.apple.quarantine'

# Functions
KUBENS_BINARY=/usr/local/bin/kubens
kubens_fzf() {
    ${KUBENS_BINARY} $(${KUBENS_BINARY} | fzf -1 --ansi -q ${1:-""})
    tmux refresh-client -S
}

gcloud_command_with_project_fzf() {
  gcloud "$@" --project $(gcloud projects list --format="get(projectId)" | fzf )
}


gotestcover() {
  outFile=$(mktemp)
  go test $@ -coverprofile=$outFile
  go tool cover -html=$outFile
}

kall () {
  for cluster in dev-gcp dev-fss dev-sbs prod-gcp prod-sbs prod-fss labs-gcp; do
    kubectl $@ --context $cluster
  done
}


check_adhoc () {
  k exec -it $1 -- wget -q -O- localhost:8080/adhoc | head -n3 | tail -n1 | jq -r .markdown
}
gcloud_set_project_fzf () {
    gcloud config set project $(gcloud projects list --format="get(projectId)" | fzf -1 --ansi -q ${1:-""}); 
    tmux refresh-client -S
}

testrig() {
  gtimeout 30 kubectl port-forward -n aura svc/testrig 8069:80 &
  sleep 5
  curl localhost:8069/adhoc | jq -r .
}

tenant_fzf () {
    nais device tenant $(echo -e "NAV\n$(gsutil ls gs://naisdevice-enroll-discovery | awk -F "/" '{print $4}')" | fzf -1 -q ${1:-""})
    nais device connect
}

for i in `seq 1 9`; do
    alias p$i="awk '{ print \$$i; }'"
done

# GH
#autoload -U compinit
#compinit -i

#kubectl autocompletion
autoload -Uz compinit
compinit
source <(kubectl completion zsh)

# Sources
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

autoload -U +X bashcompinit && bashcompinit
#complete -o nospace -C /usr/local/bin/vault vault


#export PATH="$HOME/.poetry/bin:$PATH"
  
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/rogerbjornstad/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/rogerbjornstad/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/rogerbjornstad/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/rogerbjornstad/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

. /usr/local/opt/asdf/libexec/asdf.sh
