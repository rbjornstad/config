# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=/opt/idea/bin:/opt/Postman:/opt/cfssl:/opt/node/bin:/usr/local/go/bin:/opt/helm/linux-amd64:$PATH
# Path to your oh-my-zsh installation.
  export ZSH=~/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="agnoster"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=6'
plugins=(git kubectl zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh
source ~/ws/kubeaware/kubeaware.sh
PROMPT='$(kubeaware_prompt)'$PROMPT
# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
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
