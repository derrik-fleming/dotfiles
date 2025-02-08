{ config, lib, pkgs, ... }:

{
  programs.zsh = {
    autosuggestion.enable = true;
    enable = true;
    shellAliases = {
      "vim" = "nvim";
      "zj" = "zellij";
      "f" = "fvm flutter";
      "d" = "fvm dart";
      "cd" = "z";
      "ld" = "lazydocker";
      "cat" = "bat";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [
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
    # Add environment variables here
    sessionVariables = let
      androidHome = "${config.home.homeDirectory}/Library/Android/sdk";
    in {
      # Direct variables
      ANDROID_HOME = "${config.home.homeDirectory}/Library/Android/sdk";
      ANDROID_NDK_HOME = "/usr/local/share/android-commandlinetools/ndk-bundle";
      EDITOR = "/usr/local/bin/nvim";

      # PATH modifications (combined into a single PATH entry)
      PATH = builtins.concatStringsSep ":" [
        "$PATH"  # Preserve existing PATH
        "${config.home.homeDirectory}/.pub-cache/bin"
        "${config.home.homeDirectory}/.local/share/nvim/mason/bin"
        "${config.home.homeDirectory}/.local/bin"
        "${config.home.homeDirectory}/fvm/default/bin"
        "${androidHome}/emulator"
        "${androidHome}/tools"
        "${androidHome}/tools/bin"
        "${androidHome}/platform-tools"
      ];
    };
  };
}
