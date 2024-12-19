{ config, lib, nixpkgs, disko, lanzaboote, ... }:

{
  imports = [
    lanzaboote.nixosModules.default
    disko.nixosModules.default
    ./modules/drives.nix
    ./modules/boot.nix
    ./modules/desktop.nix
    ./modules/locale.nix
    ./modules/packages.nix
    ./modules/networking.nix
    ./modules/sound.nix
    ./modules/users.nix
  ];
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "24.11";
}