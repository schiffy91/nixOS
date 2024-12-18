{ config, pkgs, lib, ... }:

let
  hostConfig = import ./hosts/${"MBP-M1-VM"}.nix { inherit config pkgs lib; };
  partition = true;
  lanzaboote = import (builtins.fetchTarball { url = "https://github.com/nix-community/lanzaboote/archive/refs/tags/v0.4.1.tar.gz"; }) + "/nixosModules" { inherit pkgs lib; };
in
{
  imports = [
    ./modules/boot
    ./modules/desktop
    ./modules/locale
    ./modules/packages
    ./modules/networking
    ./modules/sound
    ./modules/users
    hostConfig
    lanzaboote.nixosModules.default
  ] ++ (lib.optionals partition [ ./modules/partitioning ]);
  system.stateVersion = "24.11";
}