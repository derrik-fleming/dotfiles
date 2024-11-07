{ config, pkgs, ... }:

{
  # Comment out if you wish to disable unfree packages for your system
  nixpkgs.config.allowUnfree = true;
  home.username = "derrik.fleming";
  home.homeDirectory = "/Users/derrik.fleming";
  
  home.file = {
    ".config/atuin".source = ~/repos/personal/dotfiles/atuin;
    ".config/devcontainers".source = ~/repos/personal/dotfiles/devcontainers;
    ".config/dygma".source = ~/repos/personal/dotfiles/flutter;
    ".config/gh-copilot".source = ~/repos/personal/dotfiles/gh-copilot;
    ".config/kmonad".source = ~/repos/personal/dotfiles/kmonad;
    ".config/nix-darwin".source = ~/repos/personal/dotfiles/nix-darwin;
    ".config/nvim".source = ~/repos/personal/dotfiles/nvim;
    ".config/skhd".source = ~/repos/personal/dotfiles/skhd;
    ".config/starship".source = ~/repos/personal/dotfiles/starship;
    ".config/wezterm".source = ~/repos/personal/dotfiles/wezterm;
    ".config/yabai".source = ~/repos/personal/dotfiles/zellij;
    ".config/zshrc".source = ~/repos/personal/dotfiles/zsh;
  };

  home.packages = [
    pkgs.arc-browser
    pkgs.asdf
    pkgs.atuin
    pkgs.awscli2
    pkgs.bat
    pkgs.bundletool
    pkgs.cocoapods
    pkgs.commitizen
    pkgs.devcontainer
    pkgs.devpod
    pkgs.docker
    pkgs.flutter
    pkgs.fzf
    pkgs.gimp
    pkgs.git
    pkgs.gh
    pkgs.go
    pkgs.golangci-lint
    pkgs.hurl
    pkgs.kotlin
    pkgs.lazydocker
    pkgs.lazygit
    pkgs.lsd
    pkgs.mise
    pkgs.mkalias
    pkgs.neovim
    pkgs.nodejs
    pkgs.postman
    pkgs.pre-commit
    pkgs.raycast
    pkgs.ripgrep
    pkgs.ruby
    pkgs.spotify
    pkgs.sqlite
    pkgs.sshpass
    pkgs.starship
    pkgs.tableplus
    pkgs.tree
    pkgs.vscode
    pkgs.xcbeautify
    pkgs.xz
    pkgs.yarn
    pkgs.zellij
    pkgs.zoxide
    pkgs.zsh
    pkgs.oh-my-zsh
    pkgs.zsh-completions
    pkgs.zsh-syntax-highlighting
    pkgs.zulu17
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.sessionVariables = {
    ZDOTDIR = "$HOME/.config/zsh";

  };

  programs.zsh = {
    enable = true;
    oh-my-zsh.enable = true;
    oh-my-zsh.plugins = [
      "aws" 
      "node"
      "thefuck"
      "brew"
      "zsh-autosuggestions"
      "zsh-autocomplete"
    ];
  };

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  };
}
