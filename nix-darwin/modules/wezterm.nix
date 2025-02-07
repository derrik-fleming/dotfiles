{ config, pkgs, ... }:

{
  programs.wezterm = {
    enable = true;
    enableZshIntegration = true;

    extraConfig = ''
      local wezterm = require("wezterm")

      return {
        max_fps = 120,
        color_scheme = "rose-pine-moon",
        window_padding = {
          left = "1cell",
          right = "1cell",
          top = "0.15cell",
          bottom = "0.15cell",
        },
        hide_tab_bar_if_only_one_tab = true,
        window_background_opacity = 1.0,
        font_size = 15.0,
        font = wezterm.font_with_fallback({
          "Hack Nerd Font Mono",
          { family = "Symbols Nerd Font Mono", scale = 0.75 },
        }),
        front_end = "WebGpu",
      }
    '';
  };
}
