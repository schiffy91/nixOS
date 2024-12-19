{ config, pkgs, lib, ... }:

let
  disko = import ./submodules/disko/. { inherit lib; };
  lanzaboote = builtins.getFlake "./submodules/lanzaboote/flake.nix";
in
{
  imports = [
    lanzaboote.nixosModules.default
    ./modules/drives.nix
    ./hosts/${builtins.baseNameOf ./host}
    ./modules/boot.nix
    ./modules/desktop.nix
    ./modules/locale.nix
    ./modules/packages.nix
    ./modules/networking.nix
    ./modules/sound.nix
    ./modules/users.nix
  ];
  system.stateVersion = "24.11";
  extra-experimental-features = flakes;
}