{ ... }:

{
  programs.atuin = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      inline_height = 10;
      invert = true;
      show_preview = false;
      style = "compact";
    };
  };
}
