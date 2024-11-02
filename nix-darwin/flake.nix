{
  description = "Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew }:
  let
    pkgs = import inputs.nixpkgs {
      system = "x86_64-darwin";
      config = {
        allowUnfree = true;  # Allow unfree packages here
      };
    };

    # gh.kmonad = pkgs.stdenv.mkDerivation {
    #     name = "kmonad";
    #     src = pkgs.fetchFromGitHub {
    #       owner = "kmonad";
    #       repo = "kmonad";
    #       fetchSubmodules = true;
    #       rev = "3da3165c413225d924a55933b723ff8ee00f9231";
    #       sha256 = "sha256-3yJP1EmS+6DxBvFRe1eaVHmDAfi0KOXqzU+yK/0uFco=";
    #     };
    #     nativeBuildInputs = [ pkgs.ruby pkgs.stack pkgs.libiconv-darwin pkgs.libffi pkgs.darwin.xcode_15_4 ];
    #     dontBuild = true;
    #     installPhase = ''
    #       export STACK_ROOT=$PWD/.stack-root
    #       mkdir -p $STACK_ROOT
    #       stack build --flag kmonad:kext --extra-include-dirs=c_src/mac/Karabiner-VirtualHIDDevice/dist/include
    #     '';
    #   };
    #
    configuration = { pkgs, config, ... }: {
      
      nixpkgs.config.allowUnfree = true;

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        [
          # gh.kmonad
          pkgs.arc-browser
          pkgs.asdf
          pkgs.atuin
          pkgs.awscli2
          pkgs.bat
          pkgs.bundletool
          pkgs.cocoapods
          pkgs.commitizen
          pkgs.devcontainer
          pkgs.devpod
          pkgs.direnv
          pkgs.docker
          pkgs.flutter
          pkgs.fzf
          pkgs.gimp
          pkgs.git
          pkgs.gh
          pkgs.go
          pkgs.golangci-lint
          pkgs.hurl
          pkgs.kotlin
          pkgs.lazydocker
          pkgs.lazygit
          pkgs.libffi
          pkgs.libiconv-darwin
          pkgs.llvm
          pkgs.lsd
          pkgs.gnumake
          pkgs.mise
          pkgs.mkalias
          pkgs.neovim
          pkgs.nodejs
          pkgs.postman
          pkgs.pre-commit
          pkgs.raycast
          pkgs.ripgrep
          pkgs.ruby
          pkgs.spotify
          pkgs.sqlite
          pkgs.sshpass
          pkgs.starship
          pkgs.stack
          pkgs.tableplus
          pkgs.tree
          pkgs.vscode
          pkgs.xcbeautify
          pkgs.xz
          pkgs.yarn
          pkgs.zellij
          pkgs.zoxide
          pkgs.zsh
          pkgs.zulu17
        ];

      homebrew = {
        enable = true;
        brews = [
          "gcc"
          "haskell-stack"
          "mas"
          "koekeishiya/formulae/skhd"
          "koekeishiya/formulae/yabai"
          "leoafarias/fvm/fvm"
          "thefuck"
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
          "orbstack"
          "spotify"
          "vysor"
          "wezterm"
          "zed"
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
          "koekeishiya/formulae"
          "leoafarias/fvm"
        ];
      };


      fonts.packages = [
        (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
      ];

      system.activationScripts.applications.text = let
        env = pkgs.buildEnv {
          name = "system-applications";
          paths = config.environment.systemPackages;
          pathsToLink = "/Applications";
        };
      in
        pkgs.lib.mkForce ''
        # Set up applications.
        echo "setting up /Applications..." >&2
        rm -rf /Applications/Nix\ Apps
        mkdir -p /Applications/Nix\ Apps
        find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
        while read src; do
          app_name=$(basename "$src")
          echo "copying $src" >&2
          ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
        done
            '';

      system.defaults = {
        dock.autohide = true;
        dock.launchanim = false;
        dock.orientation = "right";
        dock.persistent-apps = [
          "${pkgs.arc-browser}/Applications/Arc.app"
          "/Applications/WezTerm.app"
          "/Applications/OrbStack.app"
          "/Applications/1Password.app"
          "/Applications/Spotify.app"
          "/Applications/Xcode.app/Contents/Developer/Applications/Simulator.app"
        ];
        finder.AppleShowAllFiles = true;
        finder.FXPreferredViewStyle = "clmv";
        SoftwareUpdate.AutomaticallyInstallMacOSUpdates = true;
        universalaccess.reduceMotion = true;
        universalaccess.reduceTransparency = true;
      };

      # launchd.daemons.kmonad = {
      #   script = ''
      #     ${gh.kmonad}/bin/kmonad ~/.config/kmonad/config.kbd
      #   '';
      #   serviceConfig = {
      #       KeepAlive = true;
      #       RunAtLoad = true;
      #     };
      # };

      # Auto upgrade nix package and the daemon service.
      services.nix-daemon.enable = true;
      # nix.package = pkgs.nix;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Create /etc/zshrc that loads the nix-darwin environment.
      programs.zsh = {
        enable = true;
        
        # Set ZDOTDIR to ~/.config/zsh
        shellInit = ''
          export ZDOTDIR="$HOME/.config/zsh"
        '';
      };
      # programs.fish.enable = true;

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
      modules = [
        configuration
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
