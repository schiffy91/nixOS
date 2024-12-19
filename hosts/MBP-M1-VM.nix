{ config, pkgs, lib, ... }:

{
  imports = [ ../modules/drives.nix ];

  # System information
  system = "aarch64-linux";
  networking.hostName = "MBP-M1-VM";

  # Partitioning
  customDriveConfiguration = {
    swapSize = "17G";
    target = "nvme0n1";
    
  };
}