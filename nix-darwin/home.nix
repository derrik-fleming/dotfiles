{ config, pkgs, ... }:

{
  imports = [
    ./modules/atuin.nix
    ./modules/git.nix
    ./modules/lazygit.nix
    ./modules/mise.nix
    ./modules/starship.nix
    ./modules/wezterm.nix
    ./modules/zellij.nix
    ./modules/zoxide.nix
    ./modules/zsh.nix
  ];

  # Comment out if you wish to disable unfree packages for your system
  nixpkgs.config.allowUnfree = true;
  home.username = "derrik.fleming";
  home.homeDirectory = "/Users/derrik.fleming";
  home.file = {
    ".config/aerospace".source = ../aerospace;
    ".config/dygma".source = ../flutter;
    ".config/gh-copilot".source = ../gh-copilot;
    ".config/ghostty".source = ../ghostty;
    ".config/kmonad".source =  ../kmonad;
    ".config/mise/nodejs".source = ../mise/nodejs;
    ".config/mise/python".source = ../mise/python;
    ".config/mise/ruby".source = ../mise/ruby;
    ".config/nix-darwin".source = ../nix-darwin;
    ".config/nvim/init.lua".source = ../nvim/init.lua;
    ".config/nvim/lua".source = ../nvim/lua;
    ".config/zsh".source = ../zsh;
  };

  home.packages = [
    pkgs.act
    pkgs.awscli2
    pkgs.bat
    pkgs.bundletool
    pkgs.commitizen
    pkgs.deno
    pkgs.devcontainer
    pkgs.devpod
    pkgs.docker
    pkgs.flutter
    pkgs.fzf
    pkgs.gimp
    pkgs.gh
    pkgs.golangci-lint
    pkgs.hurl
    pkgs.jetbrains-mono
    pkgs.kotlin
    pkgs.lazydocker
    pkgs.lsd
    pkgs.mkalias
    pkgs.monaspace
    pkgs.neovim
    pkgs.nixfmt
    pkgs.postman
    pkgs.pre-commit
    pkgs.raycast
    pkgs.ripgrep
    pkgs.spotify
    pkgs.sqlite
    pkgs.sshpass
    pkgs.tableplus
    pkgs.thefuck
    pkgs.tree
    pkgs.vscode
    pkgs.xcbeautify
    pkgs.xz
    pkgs.yarn
    pkgs.oh-my-zsh
    pkgs.wezterm
    pkgs.zsh-autocomplete
    pkgs.zsh-autosuggestions
    pkgs.zsh-completions
    pkgs.zsh-syntax-highlighting
    pkgs.zulu17
  ];

  fonts.fontconfig.enable = true;

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

  services.gpg-agent = {
    enable = true;
    defaultCacheTtl = 1800;
    enableSshSupport = true;
  };
}
