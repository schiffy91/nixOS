{ config, pkgs, lib, ... }:

{
  imports = [
    ./modules/boot
    ./modules/networking
    ./modules/desktop
    ./modules/sound
    ./modules/packages
    ./modules/users
    ./modules/locale
  ];

  system.stateVersion = "24.11";
}
