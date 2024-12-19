{ config, pkgs, lib, ... }:

{
  system.stateVersion = "24.11";
  imports = [
    ./dependencies/disko/default.nix
    ./dependencies/lanzaboote/default.nix
    ./modules/drives.nix
    ./modules/boot.nix
    ./modules/desktop.nix
    ./modules/locale.nix
    ./modules/packages.nix
    ./modules/networking.nix
    ./modules/sound.nix
    ./modules/users.nix
    ./hosts/${builtins.baseNameOf ./host}
  ];
}