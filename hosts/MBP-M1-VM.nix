{ config, pkgs, lib, ... }:

let
  cfg = config.custom;
in
{
  # System information
  networking.hostName = "MBP-M1-VM";

  # Partitioning
  cfg.driveConfiguration = {
    swapSize = "17G";
    target = "nvme0n1";
  };
}