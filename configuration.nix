{ config, pkgs, lib, ... }:

let
  hostConfig = import ./hosts/${"FRACTAL-NORTH"}.nix { inherit config pkgs lib; };
  partition = true;
in
{
  imports = [
    ./modules/boot
    ./modules/networking
    ./modules/desktop
    ./modules/sound
    ./modules/packages
    ./modules/users
    ./modules/locale
    hostConfig
  ] ++ (lib.optionals partition [ ./modules/partitioning ]);
  system.stateVersion = "24.11";
}