eval "$(direnv hook zsh)"

eval "$(thefuck --alias)"

eval "$(starship init zsh)"

eval "$(github-copilot-cli alias -- "$0")"

eval "$(atuin init zsh)"

eval "$(/run/current-system/sw/bin/mise activate zsh)"

source <(fzf --zsh)
