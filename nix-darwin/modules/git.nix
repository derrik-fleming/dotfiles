{ config, ... }:

{
  programs.git = {
    enable = true;
    userName = "derrik-fleming";
    userEmail = "derrik.fleming@gmail.com";
    aliases = {
      pu = "push";
      co = "checkout";
      cm = "commit";
    };
  };
}
