{
  description = "Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    kmonad.url = "git+https://github.com/derrik-fleming/kmonad?rev=a6ca5cad4cb03463eba653b7f455c119f767bbe3&dir=nix&submodules=1"; # Fetch KMonad from GitHub
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew, kmonad, home-manager }:
  # outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew }:
  let
    pkgs = import inputs.nixpkgs {
      system = "x86_64-darwin";
      config = {
        allowUnfree = true;  # Allow unfree packages here
      };
    };

    configuration = { pkgs, config, ... }: {
      nixpkgs.config.allowUnfree = true;

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        [
          kmonad.packages.${pkgs.system}.default
          pkgs.autoconf
          pkgs.automake
          pkgs.cmake
          pkgs.direnv
          pkgs.gcc
          pkgs.gmp
          pkgs.libffi
          pkgs.libtool
          pkgs.libyaml
          pkgs.openssl
          pkgs.pkg-config
          pkgs.readline
          pkgs.sshs
          pkgs.vim
          pkgs.zlib
        ];

      homebrew = {
        enable = true;
        brews = [
          "mas"
          "leoafarias/fvm/fvm"
          "radiusmethod/awsd/awsd"
          "swiftformat"
        ];

        casks = [
          "1password"
          "1password-cli"
          "android-commandlinetools"
          "android-ndk"
          "android-platform-tools"
          "android-ndk"
          "android-studio"
          "bazecor"
          "font-hack-nerd-font"
          "homerow"
          "nikitabobko/tap/aerospace"
          "orbstack"
          "vysor"
          "wezterm"
          "zed"
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
        ];
      };

      fonts.packages = [
        (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
      ];

      users.users."derrik.fleming".home = "/Users/derrik.fleming";

      system.defaults = {
        dock.autohide = true;
        dock.expose-group-by-app = true;
        dock.launchanim = false;
        dock.orientation = "right";
        dock.persistent-apps = [
          "${pkgs.arc-browser}/Applications/Arc.app"
          "/Applications/WezTerm.app"
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

      launchd.daemons.kmonad = {
        environment = {
          LANG = "en_US.UTF-8";
        };
        serviceConfig = {
          Label = "com.derrik.fleming.kmonad";
          KeepAlive = true;
          ProgramArguments = [
            "/run/current-system/sw/bin/kmonad"
            "/Users/derrik.fleming/.config/kmonad/config.kbd"
          ];
          RunAtLoad = true;
          UserName = "root";
          StandardOutPath = "/var/log/kmonad.log";
          StandardErrorPath = "/var/log/kmonad.error.log";
        };
      };

      # Auto upgrade nix package and the daemon service.
      services.nix-daemon.enable = true;
      # nix.package = pkgs.nix;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Create /etc/zshrc that loads the nix-darwin environment.
      programs.zsh = {
        enable = true;
        enableBashCompletion = true;
        enableFzfHistory = true;
        enableFzfGit = true;
      };

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "x86_64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#simple
    darwinConfigurations."work" = nix-darwin.lib.darwinSystem {
      system = "x86_64-darwin";
      pkgs = import nixpkgs { system = "x86_64-darwin"; config = { allowUnfree = true; }; };
      modules = [
        configuration
        home-manager.darwinModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users."derrik.fleming" = import ./home.nix;
        }
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            # Install Homebrew under the default prefix
            enable = true;

            # User owning the Homebrew prefix
            user = "derrik.fleming";

            # Automatically migrate existing Homebrew installations
            autoMigrate = true;
          };
        }
      ];
    };

    # Expose the package set, including overlays, for convenience.
    darwinPackages = self.darwinConfigurations."work".pkgs;
  };
}
