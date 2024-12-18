{ config, pkgs, lib, ... }:

let
  hostConfig = import ./hosts/${"MBP-M1-VM"}.nix { inherit config pkgs lib; };
  partition = true;
in
{
  imports = [
    ./modules/boot.nix
    ./modules/desktop.nix
    ./modules/locale.nix
    ./modules/packages.nix
    ./modules/networking.nix
    ./modules/sound.nix
    ./modules/users.nix
    ./lanzaboote.nix
    hostConfig
  ] ++ (lib.optionals partition [ ./modules/partitioning ]);
  system.stateVersion = "24.11";
}