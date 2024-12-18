{ config, pkgs, lib, ... }:
let
  defaultHardDrive = "/dev/nvme0n1";
  ramSize = "16G";
  system = "aarch64-linux";
in
{
  imports = [
    ../../modules/partitioning
  ];
  
  networking.hostName = "MBP-M1-NIXOS-VM";

  services.xserver.videoDrivers = [ "fbdev" ];  # Basic framebuffer driver

  hardware.opengl = {
    enable = true;
    driSupport = true;
  };

  partitioning.swapSize = ramSize;
  partitioning.defaultHardDrive = defaultHardDrive;
}