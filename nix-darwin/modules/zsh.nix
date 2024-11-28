{ config, ... }:

{
  programs.zsh = {
    autosuggestion.enable = true;
    enable = true;
    initExtra = ''
      ${builtins.readFile ../../zsh/aliases.zsh}
      ${builtins.readFile ../../zsh/environment.zsh}
      ${builtins.readFile ../../zsh/tools.zsh}
      ${builtins.readFile ../../zsh/zellij.zsh}
      ${builtins.readFile ../../zsh/zoxide.zsh}
    '';
    oh-my-zsh.enable = true;
    oh-my-zsh.plugins = [
      "1password"
      "aws"
      "brew"
      "docker"
      "flutter"
      "gh"
      "git"
      "gitignore"
      "node"
      "thefuck"
      "yarn"
    ];
  };
}
