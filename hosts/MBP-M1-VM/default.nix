{ config, pkgs, lib, ... }: {
  imports = [
    ../../modules/partitioning
  ];

  # System information
  system = "aarch64-linux";
  networking.hostName = "MBP-M1-VM";

  # Partitioning
  partitioning = lib.mkIf (lib.hasSuffix "-PARTITIONED" config.networking.hostName) {
    enable = true;
    swapSize = "17G";
    defaultHardDrive = "/dev/vda";
  };
}