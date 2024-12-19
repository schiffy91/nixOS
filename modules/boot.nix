{ config, pkgs, lib, lanzaboote, ... }:

{
  boot = {
    initrd.luks.devices."cryptroot".device = "/dev/disk/by-partlabel/cryptroot";
    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };
    loader = {
      # We need to disable systemd-boot
      systemd-boot.enable = false;
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        version = 2;
        efiSupport = true;
        device = "nodev";
        # This is important to make sure grub doesn't overwrite lanzaboote
        useOSProber = false;
          mirroredBoots = [
          {
            devices = [ "/dev/disk/by-partlabel/ESP" ];
            path = "/efi";
          }
        ];
      };
    };
  };
  virtualisation.tpm.enable = true;
}