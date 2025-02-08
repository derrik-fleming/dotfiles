{ config, lib, pkgs, ... }:

{
  programs.thefuck = {
    enable = true;
    enableZshIntegration = true;
  };
}
