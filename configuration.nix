{ config, pkgs, lib, ... }:
with (import <nixpkgs> {});
let
  disko = import ./submodules/disko/. { inherit lib; };
  lanzaboote = builtins.getFlake "./submodules/lanzaboote";
in
{
  imports = [
    #./hardware-configuration.nix
    disko.nixosModules.disko
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
}