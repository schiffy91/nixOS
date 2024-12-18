{ config, pkgs, lib, ... }: {
  imports = [
    ../../modules/partitioning
    "github:AsahiLinux/nixos-apple-silicon/module"
  ];

  # System information
  system = "aarch64-linux";
  networking.hostName = "MBP-M1-VM";

  # Asahi Linux
  hardware.asahi.audioSupport = true;

  # Enable nonfree packages (for firmware)
  nixpkgs.config.allowUnfree = [
    "asahi-fwfetch-*.all"
  ];

  # Partitioning
  partitioning = lib.mkIf (lib.hasSuffix "-PARTITIONED" config.networking.hostName) {
    enable = true;
    swapSize = "17G";
    defaultHardDrive = "/dev/vda";
  };
}