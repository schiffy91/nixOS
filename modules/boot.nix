{ config, pkgs, lib, lanzaboote, ... }:

{
  boot = {
    # Tells the system about your boot partition
    initrd.luks.devices."cryptroot".device = "/dev/disk/by-partlabel/cryptroot";
    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };
    loader = {
      systemd-boot.enable = false;
      efi.canTouchEfiVariables = true;
    };
    supportedFilesystems = [ "btrfs" ];
  };
  virtualisation.tpm.enable = true;
}