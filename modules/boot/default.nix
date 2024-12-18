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
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        configurationLimit = 2;
        consoleMode = "max";
        efiSysMountPoint = "/efi"; 
      };
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