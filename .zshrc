
# ============================================================
# Homebrew
# ============================================================

if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Remove duplicate PATH entries
typeset -U path PATH

# ============================================================
# mise - version management
# ============================================================

if command -v mise &>/dev/null; then
  eval "$(mise activate zsh)"
fi

# ============================================================
# PATH
# ============================================================

export PATH="$HOME/.local/bin:$PATH"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"

# kubectl krew plugins
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# ============================================================
# Google Cloud SDK
# ============================================================

# Manually installed SDK.
# Uses its bundled Python instead of mise Python.
if [[ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]]; then
  source "$HOME/google-cloud-sdk/path.zsh.inc"
fi

# ============================================================
# Shell completion
# ============================================================

if command -v brew &>/dev/null; then
  fpath=("$(brew --prefix)/share/zsh/site-functions" $fpath)
fi

autoload -Uz compinit
compinit

# kubectl / kubecolor / k
if command -v kubectl &>/dev/null; then
  source <(command kubectl completion zsh)
  compdef _kubectl kubecolor
  compdef _kubectl k
fi

# kubens / kns
if command -v kubens &>/dev/null; then
  _kubens() {
    local -a namespaces
    namespaces=("${(@f)$(command kubectl get namespaces -o name 2>/dev/null | sed 's#namespace/##')}")
    _describe 'namespaces' namespaces
  }

  compdef _kubens kubens
  compdef _kubens kns
fi

# kubectx / kx
if command -v kubectx &>/dev/null; then
  _kubectx() {
    local -a contexts
    contexts=("${(@f)$(command kubectl config get-contexts -o name 2>/dev/null)}")
    _describe 'contexts' contexts
  }

  compdef _kubectx kubectx
  compdef _kubectx kx
fi

# NAIS
if command -v nais &>/dev/null; then
  source <(nais completion zsh)
fi

# narc
if command -v narc &>/dev/null; then
  source <(narc completion zsh)
fi

# Google Cloud SDK completion
if [[ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]]; then
  source "$HOME/google-cloud-sdk/completion.zsh.inc"
fi

# fzf
if command -v fzf &>/dev/null; then
  eval "$(fzf --zsh)"
fi

# ============================================================
# General configuration
# ============================================================

export CDPATH=.:..:~/ws
export NPQ_DISABLE_AUTO_CONTINUE=true

# ============================================================
# Aliases
# ============================================================

# Use kubecolor when available, otherwise regular kubectl
if command -v kubecolor &>/dev/null; then
  alias kubectl='kubecolor'
fi

alias ez='vi ~/.zshrc'
alias sz='source ~/.zshrc'

alias gcp='gcloud_set_project_fzf'
alias gcsu='gcloud config set account $(gcloud auth list --format="value(account)" | fzf)'
alias gilo='git log --all --decorate --oneline --graph'
alias github='gh repo view --web'
alias glo='gcloud auth login --update-adc'
alias grw='gh run watch'

alias k='kubectl'
alias kgpn='kubectl_get_pods_by_node'
alias kns='kubens'
alias kx='kubectx'

alias ll='ls -la'
alias myip='curl -s https://icanhazip.com'
alias rg='rg --hidden'
alias rgf='rg --files | rg'

alias reset_onprem_kube_token="yq eval -i 'del(.users[] | select(.name == \"nais-user\") | .user.auth-provider.config.access-token)' ~/ws/kubeconfigs/config"

alias stripx='sudo xattr -d -r com.apple.quarantine'
alias t='tenant_fzf'
alias tmux='tmux -u'
alias ws='cd ~/ws'
alias xgcloud='gcloud_command_with_project_fzf'

# npm safety wrapper (only if installed)
if command -v npq-hero &>/dev/null; then
  alias npm='npq-hero'
fi

# ============================================================
# History
# ============================================================

export HISTFILE="${HISTFILE:-$HOME/.zsh_history}"
export HISTSIZE=50000
export SAVEHIST=10000

setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt share_history
setopt inc_append_history

# ============================================================
# Functions
# ============================================================

# Select Kubernetes namespace using fzf
kubens_fzf() {
  local kubens_binary
  kubens_binary="$(whence -p kubens)"

  if [[ -z "$kubens_binary" ]]; then
    echo "kubens is not installed"
    return 1
  fi

  local selection
  selection="$("$kubens_binary" | fzf -1 --ansi -q "${1:-}")" || return

  [[ -n "$selection" ]] || return
  "$kubens_binary" "$selection"

  if [[ -n "$TMUX" ]]; then
    tmux refresh-client -S
  fi
}

# Get pods by node name
kubectl_get_pods_by_node() {
  if [[ -z "$1" ]]; then
    echo "Usage: kgpn <nodeName>"
    return 1
  fi

  kubectl get pods -A --field-selector spec.nodeName="$1" -o wide
}

# Run gcloud command with project selector
gcloud_command_with_project_fzf() {
  local project
  project="$(gcloud projects list --format='get(projectId)' | fzf)" || return
  [[ -n "$project" ]] || return

  gcloud "$@" --project "$project"
}

# Go test with coverage viewer
gotestcover() {
  local outFile
  outFile="$(mktemp)" || return

  go test "$@" -coverprofile="$outFile" || return
  go tool cover -html="$outFile"
}

# Set Google Cloud project with fzf
gcloud_set_project_fzf() {
  local project
  project="$(gcloud projects list --format='get(projectId)' | fzf -1 --ansi -q "${1:-}")" || return
  [[ -n "$project" ]] || return

  gcloud config set project "$project"

  if [[ -n "$TMUX" ]]; then
    tmux refresh-client -S
  fi
}

# Aliases p1-p12 for awk fields
for i in {1..12}; do
  alias "p$i=awk '{ print \$$i; }'"
done

# ============================================================
# OpenCode / cplt - DISABLED
# ============================================================

# cplt is not installed on this Mac.
# Restore these functions when cplt is available.

# if command -v cplt &>/dev/null; then
#   eval "$(cplt --shell-setup)"
# fi

# _opencode_pick_repo() {
#   find "$HOME/ws" \
#     -mindepth 1 \
#     -maxdepth 1 \
#     -type d \
#     -print |
#     sort |
#     fzf \
#       --prompt='Repo > ' \
#       --height=40% \
#       --reverse \
#       --border
# }

# opencode() {
#   local gh_token
#   local read_repo
#   local -a cplt_args
#   local -a opencode_args
#
#   gh_token="$(gh auth token)" || return 1
#
#   while (( $# > 0 )); do
#     case "$1" in
#       --read-repo)
#         shift
#
#         if (( $# > 0 )) && [[ "$1" != -* ]]; then
#           read_repo="$1"
#           shift
#         else
#           read_repo="$(_opencode_pick_repo)" || return
#           [[ -n "$read_repo" ]] || return
#         fi
#
#         [[ "$read_repo" = /* ]] || read_repo="$HOME/ws/$read_repo"
#         cplt_args+=(--allow-read "$read_repo")
#         ;;
#
#       *)
#         opencode_args+=("$1")
#         shift
#         ;;
#     esac
#   done
#
#   GH_TOKEN="$gh_token" \
#     cplt \
#       --pass-env GH_TOKEN \
#       "${cplt_args[@]}" \
#       --agent opencode \
#       -- "${opencode_args[@]}"
# }

# ============================================================
# End
# ============================================================
