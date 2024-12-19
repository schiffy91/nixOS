{ config, pkgs, lib, disko, lanzaboote, host, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/drives.nix
    ./hosts/${host}
    ./modules/boot.nix
    ./modules/desktop.nix
    ./modules/locale.nix
    ./modules/packages.nix
    ./modules/networking.nix
    ./modules/sound.nix
    ./modules/users.nix
  ];
  system.stateVersion = "24.11";
}