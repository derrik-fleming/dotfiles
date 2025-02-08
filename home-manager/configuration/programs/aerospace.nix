{ ... }:

{
  programs.aerospace = {
    enable = true;
    userSettings = {
      start-at-login = true;
      enable-normalization-flatten-containers = true;
      enable-normalization-opposite-orientation-for-nested-containers = true;
      accordion-padding = 30;
      default-root-container-layout = "tiles";
      default-root-container-orientation = "auto";
      after-login-command = [];
      after-startup-command = [];
      on-focused-monitor-changed = [ "move-mouse monitor-lazy-center" ];
      automatically-unhide-macos-hidden-apps = false;
      key-mapping.preset = "qwerty";
      gaps = {
        inner = {
          horizontal = 10;
          vertical = 10;
        };
        outer = {
          left = 10;
          bottom = 10;
          top = 10;
          right = 10;
        };
      };
      mode = {
        main.binding = {
          alt-shift-left = "workspace prev";
          alt-shift-right = "workspace next";

          alt-slash = "layout tiles horizontal vertical";
          alt-comma = "layout accordion horizontal vertical";

          alt-m = "focus left";
          alt-n = "focus down";
          alt-e = "focus up";
          alt-i = "focus right";

          alt-shift-m = "move left";
          alt-shift-n = "move down";
          alt-shift-e = "move up";
          alt-shift-i = "move right";

          alt-shift-minus = "resize smart -50";
          alt-shift-equal = "resize smart +50";

          alt-t = "workspace t";
          alt-b = "workspace b";
          alt-s = "workspace s";
          alt-p = "workspace p";
          alt-1 = "workspace 1";
          alt-2 = "workspace 2";
          alt-3 = "workspace 3";
          alt-4 = "workspace 4";
          alt-5 = "workspace 5";

          alt-shift-t = "move-node-to-workspace t";
          alt-shift-b = "move-node-to-workspace b";
          alt-shift-s = "move-node-to-workspace s";
          alt-shift-p = "move-node-to-workspace p";
          alt-shift-1 = "move-node-to-workspace 1";
          alt-shift-2 = "move-node-to-workspace 2";
          alt-shift-3 = "move-node-to-workspace 3";
          alt-shift-4 = "move-node-to-workspace 4";
          alt-shift-5 = "move-node-to-workspace 5";

          alt-tab = "workspace-back-and-forth";
          alt-shift-tab = "move-workspace-to-monitor --wrap-around next";

          alt-shift-semicolon = "mode service";
        };

        service.binding = {
          esc = [ "reload-config" "mode main" ];
          r = [ "flatten-workspace-tree" "mode main" ];
          f = [ "layout floating tiling" "mode main" ];
          backspace = [ "close-all-windows-but-current" "mode main" ];

          alt-shift-m = [ "join-with left" "mode main" ];
          alt-shift-n = [ "join-with down" "mode main" ];
          alt-shift-e = [ "join-with up" "mode main" ];
          alt-shift-i = [ "join-with right" "mode main" ];

          down = "volume down";
          up = "volume up";
          shift-down = [ "volume set 0" "mode main" ];
        };
      };

      on-window-detected = [
        {
          check-further-callbacks = false;
          "if" = {
            window-title-regex-substring = "Android Emulator - Pixel_8_API_35:5554";
          };
          run = [ "layout tiling" ];
        }
        {
          check-further-callbacks = false;
          "if" = {
            window-title-regex-substring = "CarPlay";
          };
          run = [ "layout tiling" ];
        }
        {
          check-further-callbacks = false;
          "if" = {
            app-id = "com.mitchellh.ghostty";
          };
          run = [ "layout tiling" "move-node-to-workspace t" ];
        }
        {
          check-further-callbacks = false;
          "if" = {
            app-id = "app.zen-browser.zen";
          };
          run = [ "layout tiling" "move-node-to-workspace b" ];
        }
        {
          check-further-callbacks = false;
          "if" = {
            app-id = "com.spotify.client";
          };
          run = [ "layout tiling" "move-node-to-workspace s" ];
        }
        {
          check-further-callbacks = false;
          "if" = {
            app-id = "com.1password.1password";
          };
          run = [ "layout tiling" "move-node-to-workspace p" ];
        }
      ];
    };
  };
}

