{ config, pkgs, lib, ... }:

{
  # System Packages
  environment.systemPackages = with pkgs; [
    micro
    wget
    distrobox
    vscode
    pciutils
    usbutils
    google-chrome
    sbctl
  ];
}
