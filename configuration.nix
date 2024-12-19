{ config, pkgs, lib, ... }:

let
  disko = import (builtins.fetchTarball { url = "https://github.com/nix-community/disko/archive/master.tar.gz"; }) { inherit lib; };
  lanzaboote = import (builtins.fetchTarball { url = "https://github.com/nix-community/lanzaboote/archive/master.tar.gz"; }) { inherit lib pkgs; };
  hostConfig = import ./hosts/${builtins.baseNameOf ./host} { inherit config pkgs lib disko lanzaboote; };
in
{
  imports = [
    disko.nixosModules.disko
    lanzaboote.nixosModules.lanzaboote
    ./modules/boot.nix
    ./modules/desktop.nix
    ./modules/locale.nix
    ./modules/packages.nix
    ./modules/networking.nix
    ./modules/sound.nix
    ./modules/users.nix
    hostConfig
  ];
  system.stateVersion = "24.11";
}