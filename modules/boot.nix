{ config, lib, pkgs, disko, lanzaboote, ... }:

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