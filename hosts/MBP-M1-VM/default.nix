{ config, pkgs, lib, ... }:
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

  partitioning = config.partitioning // {
    enable = false;
    swapSize = "17G";
    defaultHardDrive = "/dev/nvme0n1";
  };
}