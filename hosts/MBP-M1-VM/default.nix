{ config, pkgs, lib, ... }:
{
  imports = [
    ../../modules/partitioning
  ];

  system.system = "aarch64-linux";
  networking.hostName = "MBP-M1-VM";

  nixpkgs.config.packageOverrides = pkgs: {
    mesa = pkgs.mesa.override {
      drivers = [ pkgs.asahi ];
    };
  };
  boot.kernelPackages = pkgs.linuxPackages_asahi;

  partitioning = config.partitioning // {
    enable = false;
    swapSize = "17G";
    defaultHardDrive = "/dev/nvme0n1";
  };
}