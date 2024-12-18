{ config, pkgs, lib, ... }:

{
  imports = [
    ./modules/boot
    ./modules/networking
    ./modules/desktop
    ./modules/sound
    ./modules/virtualization
    ./modules/packages
    ./modules/users
    ./modules/locale
  ];

  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "24.11";
}
