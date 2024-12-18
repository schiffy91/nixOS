{ config, pkgs, lib, ... }:

let
    sources = import ./nix/sources.nix;
    lanzaboote = import sources.lanzaboote;
in
{
  # Lanzaboote for Secure Boot
  imports = [ lanzaboote.nixosModules.lanzaboote ];
  environment.systemPackages = [ pkgs.sbctl ];
  boot = {
    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };
    loader = {
      systemd-boot.enable = lib.mkForce false;
      efi.canTouchEfiVariables = true;
    };
  };

  # Setup keyfile for Secure Boot
  system.activationScripts.postActivation.text = ''
    if ! ${pkgs.sbctl}/bin/sbctl status | grep "Setup Mode: false"; then
      if ! ${pkgs.sbctl}/bin/sbctl verify; then
        ${pkgs.sbctl}/bin/sbctl enroll-keys --microsoft
      fi
    fi
  '';
}