eval "$(direnv hook zsh)"

eval "$(thefuck --alias)"

eval "$(starship init zsh)"

eval "$(github-copilot-cli alias -- "$0")"

eval "$(atuin init zsh)"

source <(fzf --zsh)
