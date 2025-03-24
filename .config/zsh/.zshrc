eval "$(starship init zsh)"

# starship, install if missing
if ! command -v starship >/dev/null 2>&1; then
  curl -sS https://starship.rs/install.sh | sh
fi
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

# krew, install if missing
if command -v kubectl >/dev/null 2>&1 && [[ ! -d "${KREW_ROOT:-$HOME/.krew}/bin" ]]; then
  (
    set -x; cd "$(mktemp -d)" &&
    OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
    ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
    KREW="krew-${OS}_${ARCH}" &&
    curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
    tar zxvf "${KREW}.tar.gz" &&
    ./"${KREW}" install krew
  )
fi
if [[ -d "${KREW_ROOT:-$HOME/.krew}/bin" ]]; then
  export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
fi

# zsh plugins
plugins=(zsh-autosuggestions zsh-syntax-highlighting zsh-history-substring-search)
for plugin in $plugins; do
  if [[ ! -d $XDG_DATA_HOME/zsh/$plugin ]]; then
    git clone "https://github.com/zsh-users/${plugin}.git" "$XDG_DATA_HOME/zsh/$plugin"
  fi
  source "$XDG_DATA_HOME/zsh/$plugin/$plugin.zsh"
done

# completion
autoload -U compinit
compinit -d "$XDG_DATA_HOME/zsh/zcompdump"
zstyle ':completion:*' completer _extensions _complete _approximate
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==02=01}:${(s.:.)LS_COLORS}")'

# history
setopt hist_ignore_dups
setopt hist_ignore_space
setopt inc_append_history
export HISTFILE="$XDG_DATA_HOME/zsh/history"
export HISTSIZE=100000
# needed for vimtex-neovim
export DBUS_SESSION_BUS_ADDRESS="unix:path=$DBUS_LAUNCHD_SESSION_BUS_SOCKET"
# pretty man pages
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# aliases
alias v="nvim"
alias ls="ls -Gh"
alias ll="ls -l"
alias l="ls -l"
alias la="ls -a"
alias lal="ls -al"
alias ..="cd .."
alias ...="cd ../.."
alias g="git"
alias h='history -t "%d.%m.%y-%H:%M:%S"'
alias k=kubectl

# kubectl
if command -v kubectl >/dev/null 2>&1; then
  source <(kubectl completion zsh)
  if command -v kubecolor >/dev/null 2>&1; then
    # Make "kubecolor" borrow the same completion logic as "kubectl"
    compdef kubecolor=kubectl
  fi
fi

# tmux
export TMUX_PLUGIN_MANAGER_PATH=$XDG_DATA_HOME/tmux/plugins
# Create tmux dir for its data (plugins)
if [[ ! -d $XDG_DATA_HOME/tmux/plugins ]]; then
  mkdir -p "$XDG_DATA_HOME"/tmux/plugins
fi

# fzf
if command -v fzf >/dev/null 2>&1; then
  source <(fzf --zsh)
else
  echo "fzf not found"
fi

if [[ -n $TMUX ]]; then
  export TERM="tmux-256color"
fi

# asdf
if [[ -f $HOME/.asdf/asdf.sh ]]; then
  . $HOME/.asdf/asdf.sh
elif [[ -f /usr/local/opt/asdf/libexec/asdf.sh ]]; then
  . /usr/local/opt/asdf/libexec/asdf.sh
fi
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"


# direnv
eval "$(asdf exec direnv hook zsh)"

# source "${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/zshrc"

# bindkey
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down