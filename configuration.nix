{ config, pkgs, lib, ... }:

let
  hostConfig = import ./hosts/${"MBP-M1-VM"}.nix { inherit config pkgs lib; };
  partition = true;
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
    ./lanzaboote.nix
    hostConfig
  ] ++ (lib.optionals partition [ ./modules/partitioning ]);
  system.stateVersion = "24.11";
}