# Homebrew shell environment setup
eval "$(/opt/homebrew/bin/brew shellenv)"

# Setup fpath and zsh completions if brew is available
if type brew &>/dev/null; then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi

# Safer completion sources for kubectl and nais
if command -v kubectl &>/dev/null; then
  source <(kubectl completion zsh)
fi

compdef kubecolor=kubectl

# Custom completion for kubens (kns alias)
if command -v kubens &>/dev/null; then
  _kubens() {
    local context
    context="$(kubectl config current-context 2>/dev/null)"
    if [[ -n "$context" ]]; then
      _alternative 'namespaces:namespaces:($(kubectl get namespaces -o name 2>/dev/null | sed "s/namespace\///"))'
    fi
  }
  compdef _kubens kubens
  compdef _kubens kns
fi

# Custom completion for kubectx (kx alias)
if command -v kubectx &>/dev/null; then
  _kubectx() {
    _alternative 'contexts:contexts:($(kubectl config get-contexts -o name 2>/dev/null))'
  }
  compdef _kubectx kubectx
  compdef _kubectx kx
fi

if command -v nais &>/dev/null; then
  source <(nais completion zsh)
fi

if command -v narc &>/dev/null; then
  source <(narc completion zsh)
fi

# Google Cloud SDK completions and path
source "$(brew --prefix)/share/google-cloud-sdk/path.zsh.inc"
source "$(brew --prefix)/share/google-cloud-sdk/completion.zsh.inc"

# fzf setup if installed
if command -v fzf &>/dev/null; then
  eval "$(fzf --zsh)"
fi

# Add krew to PATH
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# CDPATH shortcuts
export CDPATH=.:..:~/ws

# NPQ Disable auto continue
export NPQ_DISABLE_AUTO_CONTINUE=true


# Aliases
alias code='code .'
alias kubectl=kubecolor
alias ez='vi ~/.zshrc'
alias gcp='gcloud_set_project_fzf'
alias gcsu='gcloud config set account $(gcloud auth list --format="value(account)" | fzf)'
alias gilo='git log --all --decorate --oneline --graph'
alias github='gh repo view --web'
alias glo='gcloud auth login --update-adc'
alias grw='gh run watch'
alias k='kubectl'
compdef __start_kubectl k
alias kgpn='kubectl_get_pods_by_node'
alias kns='kubens'
alias kx='kubectx'
alias ll='ls -la'
alias myip='curl https://icanhazip.com/s 2>/dev/null'
alias reset_onprem_kube_token="yq eval -i 'del(.users[] | select(.name == \"nais-user\") | .user.auth-provider.config.access-token)' ~/ws/kubeconfigs/config"
alias rg='rg --hidden'
alias rgf='rg --files | rg'
alias stripx='sudo xattr -d -r com.apple.quarantine'
alias sz='source ~/.zshrc'
alias t='tenant_fzf'
alias tmux='tmux -u'
alias ws='cd ~/ws'
alias xgcloud='gcloud_command_with_project_fzf'

# History configuration
export HISTFILE="${HISTFILE:-$HOME/.zsh_history}"
export HISTSIZE=50000
export SAVEHIST=10000

setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data
setopt inc_append_history

# Functions

# kubens binary path
KUBENS_BINARY=/usr/local/bin/kubens

kubens_fzf() {
    ${KUBENS_BINARY} $(${KUBENS_BINARY} | fzf -1 --ansi -q ${1:-""})
    tmux refresh-client -S
}


# Fix for kgpn: get pods by node name
kubectl_get_pods_by_node() {
  if [ -z "$1" ]; then
    echo "Usage: kgpn <nodeName>"
    return 1
  fi
  kubectl get pods -A --field-selector spec.nodeName="$1" -o wide
}

# gcloud helper with project fzf selector
gcloud_command_with_project_fzf() {
  gcloud "$@" --project "$(gcloud projects list --format='get(projectId)' | fzf)"
}

# go test with coverage viewer
gotestcover() {
  local outFile
  outFile=$(mktemp)
  go test "$@" -coverprofile="$outFile"
  go tool cover -html="$outFile"
}

# gcloud project set with fzf
gcloud_set_project_fzf () {
    gcloud config set project "$(gcloud projects list --format='get(projectId)' | fzf -1 --ansi -q ${1:-""})"
    tmux refresh-client -S
}

# Aliases p1-p12 for awk fields
for i in $(seq 1 12); do
  alias p$i="awk '{ print \$$i; }'"
done

# mise activate (ensure mise is installed and on PATH)
if command -v mise &>/dev/null; then
  eval "$(mise activate zsh)"
fi
alias npm='npq-hero'

# pnpm
export PNPM_HOME="/Users/roger/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac
# pnpm end
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
eval "$(cplt --shell-setup)"

_opencode_pick_repo() {
  find "$HOME/ws" \
    -mindepth 1 \
    -maxdepth 1 \
    -type d \
    -print |
    sort |
    fzf \
      --prompt='Repo > ' \
      --height=40% \
      --reverse \
      --border
}

opencode() {
  local gh_token
  local read_repo
  local -a cplt_args
  local -a opencode_args

  gh_token="$(gh auth token)" || return 1

  while (( $# > 0 )); do
    case "$1" in
      --read-repo)
        shift

        if (( $# > 0 )) && [[ "$1" != -* ]]; then
          read_repo="$1"
          shift
        else
          read_repo="$(_opencode_pick_repo)" || return
          [[ -n "$read_repo" ]] || return
        fi

        [[ "$read_repo" = /* ]] || read_repo="$HOME/ws/$read_repo"
        cplt_args+=(--allow-read "$read_repo")
        ;;

      *)
        opencode_args+=("$1")
        shift
        ;;
    esac
  done

  GH_TOKEN="$gh_token" \
    cplt \
      --pass-env GH_TOKEN \
      "${cplt_args[@]}" \
      --agent opencode \
      -- "${opencode_args[@]}"
}

export PATH="$HOME/.local/bin:$PATH"
