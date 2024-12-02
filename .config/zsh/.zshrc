eval "$(starship init zsh)"

export LS_OPTIONS='--color=auto'
eval "$(dircolors)"
alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -l'
alias l='ls $LS_OPTIONS -lA'

# zsh autosuggestions plugin enable
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
