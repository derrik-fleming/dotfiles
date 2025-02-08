{ config, ... }:

{
  programs.git = {
    enable = true;
    userName = "derrik-fleming";
    userEmail = "derrik.fleming@mutuallyhuman.com";
    aliases = {
      pu = "push";
      co = "checkout";
      cm = "commit";
    };
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
      core = {
        editor = "nvim";
      };
      diff = {
        tool = "nvimdiff";
      };
      difftool = {
        nvimdiff = {
          cmd = "nvim -d $LOCAL $REMOTE -c \"$wincmd w\" -c \"wincmd L\"";
        };
      };
      merge = {
        tool = "nvimdiff";
      };
      mergetool = {
        nvimdiff = {
          cmd = "nvim -d $LOCAL $MERGED $REMOTE -c \"wincmd l\" -c \"wincmd h\"";
        };
      };
    };
  };
}
