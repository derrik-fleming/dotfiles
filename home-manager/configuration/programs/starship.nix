{ config, lib, ... }:

{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      format = lib.concatStrings [
        "$username "
        "$directory "
        "$git_branch "
        "$git_status "
        "$fill "
        "$aws "
        "$golang "
        "$java "
        "$nodejs "
        "$rust "
        "$python "
        "\n  "
        "[󱞪](fg:iris)  "
      ];

      palette = "rose-pine-moon";

      palettes.rose-pine-moon = {
        overlay = "#393552";
        love = "#eb6f92";
        gold = "#f6c177";
        rose = "#ea9a97";
        pine = "#3e8fb0";
        foam = "#9ccfd8";
        iris = "#c4a7e7";
      };

      directory = {
        format = "[](fg:overlay)[ $path ]($style)[](fg:overlay)";
        style = "bg:overlay fg:pine";
        truncation_length = 3;
        truncation_symbol = "…/";
        substitutions = {
          Documents = "󰈙";
          Downloads = " ";
          Music = " ";
          Pictures = " ";
        };
      };

      fill = {
        style = "fg:overlay";
        symbol = " ";
      };

      aws = {
        format = "[](fg:overlay)[🅰 $profile $region]($style)[](fg:overlay) ";
        style = "bg:overlay fg:foam";
      };

      git_branch = {
        format = "[](fg:overlay)[ $symbol $branch ]($style)[](fg:overlay)";
        style = "bg:overlay fg:foam";
        symbol = "";
      };

      git_status = {
        disabled = true;
        style = "bg:overlay fg:love";
      };

      time = {
        disabled = false;
        format = "[](fg:overlay)[ $time 󰴈 ]($style)[](fg:overlay)";
        style = "bg:overlay fg:rose";
        time_format = "%I:%M%P";
        use_12hr = true;
      };

      username = {
        disabled = false;
        format = "[](fg:overlay)[ 󰧱 $user ]($style)[](fg:overlay)";
        show_always = true;
        style_root = "bg:overlay fg:iris";
        style_user = "bg:overlay fg:iris";
      };

      golang = {
        style = "bg:overlay fg:pine";
        format = "[](fg:overlay)[$symbol$version]($style)[](fg:overlay) ";
        disabled = false;
        symbol = " ";
      };

      java = {
        style = "bg:overlay fg:pine";
        format = "[](fg:overlay)[$symbol$version]($style)[](fg:overlay) ";
        disabled = false;
        symbol = " ";
      };

      nodejs = {
        style = "bg:overlay fg:pine";
        format = "[](fg:overlay)[$symbol$version]($style)[](fg:overlay) ";
        disabled = false;
        symbol = "󰎙 ";
      };

      rust = {
        style = "bg:overlay fg:pine";
        format = "[](fg:overlay)[$symbol$version]($style)[](fg:overlay) ";
        disabled = false;
        symbol = "";
      };

      python = {
        style = "bg:overlay fg:pine";
        format = "[](fg:overlay)[$symbol$version]($style)[](fg:overlay) ";
        disabled = false;
        symbol = " ";
      };
    };
  }; 
}
