{ ... }:

{
  programs.zellij = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      theme = "rose-pine-moon";
      themes."rose-pine-moon" = {
        fg = "#e0def4";
        bg = "#44415a";
        red = "#eb6f92";
        green = "#3e8fb0";
        blue = "#9ccfd8";
        yellow = "#f6c177";
        magenta = "#c4a7e7";
        orange = "#fe640b";
        cyan = "#ea9a97";
        black = "#393552";
        white = "#e0def4";
      };
    };
  };
}
