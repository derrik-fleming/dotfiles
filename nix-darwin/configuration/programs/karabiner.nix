{ config, pkgs, ... }:

{
  # Disable the nix-darwin built-in module if needed
  disabledModules = [
    "services/karabiner-elements.nix"
  ];

  imports = [
    # Import your custom module
    ../../modules/services/karabiner.nix
  ];

  

  # Configure your custom karabiner-elements
  services.karabiner = {
    enable = true;
    # Add any custom options you defined
  };

  # Rest of your configuration...
}
