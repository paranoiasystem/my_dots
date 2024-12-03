eval "$(starship init zsh)"

# starship, install if missing
if ! command -v starship >/dev/null 2>&1; then
  curl -sS https://starship.rs/install.sh | sh
fi
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
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
alias gs="git status"
alias gl="git log"
alias gd="git diff"
alias gc="git commit"
alias gb="git branch"
alias ga="git add"
alias gp="git push"
alias h='history -t "%d.%m.%y-%H:%M:%S"'

# tmux
export TMUX_PLUGIN_MANAGER_PATH=$XDG_DATA_HOME/tmux/plugins
# Create tmux dir for its data (plugins)
if [[ ! -d $XDG_DATA_HOME/tmux/plugins ]]; then
  mkdir -p "$XDG_DATA_HOME"/tmux/plugins
fi

if [[ -n $TMUX ]]; then
  export TERM="tmux-256color"
fi
