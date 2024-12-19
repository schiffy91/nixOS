{ config, pkgs, lib, lanzaboote, ... }:

let
  cfg = config.custom;
in
{
  boot = {
    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };
    loader = {
      systemd-boot.enable = false;
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        version = 2;
        efiSupport = true;
        device = "/dev/${cfg.driveConfiguration.target}";
        useOSProber = false;
        mirroredBoots = [
          {
            devices = [ "/dev/disk/by-partlabel/ESP" ];
            path = "/efi/a";
          }
          {
            devices = [ "/dev/disk/by-partlabel/ESP" ];
            path = "/efi/b";
          }
        ];
      };
    };
  };
  virtualisation.tpm.enable = true;
}