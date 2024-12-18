{ config, pkgs, lib, ... }:

{
  # System information
  system.system = "aarch64-linux";
  networking.hostName = "MBP-M1-VM";

  # Partitioning
  partitioning = {
    swapSize = "17G";
    target = "/dev/nvme0n1";
  };
}