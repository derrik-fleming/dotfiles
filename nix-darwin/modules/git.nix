{ config, ... }:

{
  programs.git = {
    enable = true;
    userName = "derrik-fleming";
    userEmail = "derrik.fleming@spindance.com";
    aliases = {
      pu = "push";
      co = "checkout";
      cm = "commit";
    };
  };
}
