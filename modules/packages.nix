{ config, pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    micro
    wget
    distrobox
    vscode
    pciutils
    usbutils
    google-chrome
    sbctl niv
  ];
}
