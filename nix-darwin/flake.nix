{
  description = "Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew, home-manager }:
  let
    pkgs = import inputs.nixpkgs {
      system = "x86_64-darwin";
    };

    configuration = { pkgs, config, ... }: {
      environment.systemPackages =
        [
          pkgs.direnv
          pkgs.openssl
          pkgs.pkg-config
          pkgs.vim
        ];

      homebrew = {
        enable = true;
        brews = [
          "mas"
          "leoafarias/fvm/fvm"
          "jwt-cli"
          "kanata"
          "radiusmethod/awsd/awsd"
          "swiftformat"
        ];

        casks = [
          "1password"
          "1password-cli"
          "android-commandlinetools"
          "android-ndk"
          "android-platform-tools"
          "android-studio"
          "arc"
          "bazecor"
          "font-hack-nerd-font"
          "ghostty"
          "homerow"
          "orbstack"
          "temurin"
          "zen-browser"
        ];

        masApps = {
          "XCode" = 497799835;
        };

        onActivation = {
          autoUpdate = true;
          cleanup = "zap";
          upgrade = true;
        };

        taps = [
          "leoafarias/fvm"
          "nikitabobko/tap"
          "radiusmethod/awsd"
        ];
      };

      users.users."derrik.fleming".home = "/Users/derrik.fleming";

      system.defaults = {
        dock.autohide = true;
        dock.expose-group-apps = true;
        dock.launchanim = false;
        dock.orientation = "right";
        dock.persistent-apps = [
          "/Applications/Zen Browser.app"
          "/Applications/Ghostty.app"
          "/Applications/OrbStack.app"
          "/Applications/1Password.app"
          "${pkgs.spotify}/Applications/Spotify.app"
          "/Applications/Xcode.app/Contents/Developer/Applications/Simulator.app"
        ];
        finder.AppleShowAllFiles = true;
        finder.FXPreferredViewStyle = "clmv";
        SoftwareUpdate.AutomaticallyInstallMacOSUpdates = true;
        universalaccess.reduceMotion = true;
        universalaccess.reduceTransparency = true;
      };

      launchd.daemons.karabiner_virtual_hid_device = {
        environment = {
          LANG = "en_US.UTF-8";
        };
        serviceConfig = {
          Label = "com.derrik.fleming.karabiner-virtual-hid-device";
          KeepAlive = true;
          ProgramArguments = [
            "/Library/Application Support/org.pqrs/Karabiner-DriverKit-VirtualHIDDevice/Applications/Karabiner-VirtualHIDDevice-Daemon.app/Contents/MacOS/Karabiner-VirtualHIDDevice-Daemon"
          ];
          RunAtLoad = true;
          UserName = "root";
          StandardOutPath = "/var/log/karabiner-virtual-hid-device.log";
          StandardErrorPath = "/var/log/karabiner-virtual-hid-device.error.log";
        };
      };

      launchd.daemons.kanata = {
        environment = {
          LANG = "en_US.UTF-8";
        };
        serviceConfig = {
          Label = "com.derrik.fleming.kanata";
          KeepAlive = true;
          ProgramArguments = [
            "/usr/local/bin/kanata"
             "-c"
            "/Users/derrik.fleming/.config/kanata/config.kbd"
          ];
          RunAtLoad = true;
          UserName = "root";
          StandardOutPath = "/var/log/kanata.log";
          StandardErrorPath = "/var/log/kanata.error.log";
        };
      };

      nix.enable = true;
      nix.settings.experimental-features = "nix-command flakes";

      system.configurationRevision = self.rev or self.dirtyRev or null;
      system.stateVersion = 5;
      nixpkgs.hostPlatform = "x86_64-darwin";
    };
  in
  {
    darwinConfigurations."work" = nix-darwin.lib.darwinSystem {
      system = "x86_64-darwin";
      pkgs = import nixpkgs { 
          system = "x86_64-darwin";
          config = {
            allowUnfree = true;
          };
        };
      modules = [
        configuration
        home-manager.darwinModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users."derrik.fleming" = import ../home-manager/home.nix;
        }
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            user = "derrik.fleming";
            autoMigrate = true;
          };
        }
      ];
    };
    darwinPackages = self.darwinConfigurations."work".pkgs;
  };
}
