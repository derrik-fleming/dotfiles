{ config, lib, pkgs, ... }:

{
  imports = [
    ./programs/default.nix
    ./services/default.nix
  ];
}
