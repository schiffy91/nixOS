{ config, pkgs, lib, ... }:

let
  lanzaboote = builtins.getFlake "github:nix-community/lanzaboote";
in
{
  imports = [
    ./nix/modules/lanzaboote.nix
    lanzaboote.nixosModules.lanzaboote
  ];

  # Enable Secure Boot with self-signed keys.
  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/etc/secureboot";
  };

  # This is needed until the `systemd-boot` module is removed.
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;

  # For TPM2 support, enable this.
  virtualisation.tpm.enable = true;
}