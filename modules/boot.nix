{ config, pkgs, lib, ... }:

let
  cfg = config.custom;
in
{
  boot = {
    disko.enableConfig = true;
    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };
    loader = {
      systemd-boot.enable = lib.mkForce false;
      efi.canTouchEfiVariables = true;
      grub = {
        enable = lib.mkForce false;
      };
    };
  };
  uefi.secureBoot = {
    enable = true;
  };
  virtualisation.tpm.enable = true;
}