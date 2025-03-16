{ config, ... }:

{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
  };
}
