{ config, pkgs, lib, ... }:

{
  # Lanzaboote for Secure Boot
  system.activationScripts.preActivation.text = ''
    if [ ! -d /etc/secureboot ]; then
      mkdir -p /etc/secureboot
      chmod 700 /etc/secureboot
    fi
  '';

  boot = {
    lanzaboote = {
      enable = true;
      pkiBundle = "/etc/secureboot";
    };
    loader = {
      systemd-boot.enable = lib.mkForce false; # let disko handle this
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
    supportedFilesystems = [ "btrfs" ];
  };

  # Setup keyfile for Secure Boot
  system.activationScripts.postActivation.text = ''
    if ! ${pkgs.sbctl}/bin/sbctl verify; then
      ${pkgs.sbctl}/bin/sbctl enroll-keys --microsoft
    fi
  '';
}
