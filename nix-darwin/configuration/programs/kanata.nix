{ config, lib, pkgs, ... }:

{
  # Import the Kanata module (if it's not already part of your environment)
  # If this is a standalone module file, you might need to import it explicitly.
  imports = [ ./../../modules/services/kanata.nix ]; # Uncomment if the module is in a separate file

  services.kanata = {
    enable = true; # Enable Kanata
    package = pkgs.runCommand "kanata" {} ''
      mkdir -p $out/bin
      ln -s /opt/homebrew/bin/kanata $out/bin/kanata
    '';

    keyboards = {
      # Define a keyboard configuration named "main"
      main = {
        # The Kanata configuration as a string
        config = ''
          (defsrc
            esc
            grv  1   2   3   4   5   6   7   8   9   0   -   =
            tab  q   w   e   r   t   y   u   i   o   p   [   ]
            caps a   s   d   f   g   h   j   k   l   ;   '   \
            lsft z   x   c   v   b   n   m   ,   .   /   rsft
            lctl lalt lmet      spc          rmet ralt
          )
          (defvar
            tap-time 0
            hold-time 350
          )
          (defalias
            hyper (multi lsft lctl lalt lmet)
            a (tap-hold $tap-time $hold-time a lctl)
            r (tap-hold $tap-time $hold-time r lalt)
            s (tap-hold $tap-time $hold-time s lmet)
            t (tap-hold $tap-time $hold-time t lsft)
            n (tap-hold $tap-time $hold-time n rsft)
            e (tap-hold $tap-time $hold-time e rmet)
            i (tap-hold $tap-time $hold-time i ralt)
            o (tap-hold $tap-time $hold-time o rctl)
            ehyp (tap-hold-release $tap-time $hold-time esc @hyper)
            ll (layer-toggle layer-left)
            lr (layer-toggle layer-right)
            lb (layer-toggle layer-both)
          )
          (deflayer default
            esc
            grv  1   2   3   4   5   6   7   8   9   0   -   =
            tab  q   w   f   p   b   j   l   u   y   ;   [   ]
            @ehyp @a  @r  @s  @t  g   m   @n  @e  @i  @o   '   \
            lsft x   c   d   v   z   k   h   ,   .   /   rsft
            lctl lalt @ll      spc          @lr ralt
          )
          (deflayer layer-left
            esc
            grv  _   _   _   _   _   _   _   _   _   _   _   _
            S-` S-1 S-2 S-3 S-4 S-5 S-6 S-7 S-8 S-9 S-0   [   ]
            @ehyp @a  @r  @s  @t  g   h   _   +   {   }   '   \
            lsft _   _   _   _   _   _   _   _   [   ]   rsft
            lctl lalt @ll      spc          @lb ralt
          )
          (deflayer layer-right
            esc
            grv  _   _   _   _   _   _   _   _   _   _   _   _
            `    1   2   3   4   5   6   7   8   9   0   [   ]
            @ehyp @a  @r  @s  @t  _   _   -   =   [   ]   \   \
            lsft _   _   _   _   _   _   _   _   _   _   rsft
            lctl lalt @lb      spc         @lr ralt
          )
          (deflayer layer-both
            esc
            grv  _   _   _   _   _   _   _   _   _   _   _   _
            esc  _   _   _   _   _   _   _   _   _   _   [   ]
            @ehyp C-1  C-2  C-3  C-4  _   left   down  up  right  _   '   \
            lsft _   _   _   _   _   _      _     _   _      _   rsft
            lctl lalt _        spc          _ ralt
          )
        '';

        extraDefCfg = ''
          # Add any additional defcfg settings here if required
          # For example: process-unmapped-keys true
        '';

        extraArgs = [ ];

      };
    };
  };
}
