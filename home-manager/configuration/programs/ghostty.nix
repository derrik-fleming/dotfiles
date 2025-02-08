{ ... }:

{
  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;
    package = null;

    settings = {
      window-padding-x = 8;
      font-family = ["Monaspace Neon" "Symbols Nerd Font Mono"];
      font-feature = ["calt" "liga" "ss01" "ss02" "ss03" "ss04" "ss05" "ss06" "ss07" "ss08" "ss09"];
      font-size = 15;
      macos-option-as-alt = true;
      theme = "rose-pine-moon";
      palette = ["2=#3e8fb0" "10=#3e8fb0" "4=#9ccfd8" "12=#9ccfd8"];
      selection-background = "#44415a";
      cursor-color = "#ea9a97";
    };
  };
}
