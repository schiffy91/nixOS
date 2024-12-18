{ config, pkgs, lib, config ? {}, ... }:
{
  imports = [
    ../../modules/partitioning
  ];
  
  system.system = "aarch64-linux";
  networking.hostName = "MBP-M1-VM";
  
  services.xserver.videoDrivers = [ "fbdev" ];
  hardware.opengl = {
    enable = true;
    driSupport = true;
  };

  partitioning = {
    enable = config.partitioning.enable or false;
    swapSize = "16G";
    defaultHardDrive = "/dev/nvme0n1";
  };
}