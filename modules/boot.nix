{ config, pkgs, lib, lanzaboote, ... }:

{
  boot = {
    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };
    loader = {
      systemd-boot.enable = false;
      efi.canTouchEfiVariables = true;
    }
  };
  virtualisation.tpm.enable = true;
}