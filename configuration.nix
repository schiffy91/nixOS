{ config, pkgs, lib, ... }:

let
  disko = import ./dependencies/disko { inherit lib; };
  lanzaboote = import ./dependencies/lanzaboote { inherit lib pkgs; };
  hostConfig = import ./hosts/${builtins.baseNameOf ./host} { inherit config pkgs lib; };
in
{
  system.stateVersion = "24.11";
  imports = [
    disko.nixosModules.disko
    lanzaboote.nixosModules.lanzaboote
    ./modules/drives.nix
    ./modules/boot.nix
    ./modules/desktop.nix
    ./modules/locale.nix
    ./modules/packages.nix
    ./modules/networking.nix
    ./modules/sound.nix
    ./modules/users.nix
    hostConfig
  ];
}