{ config, pkgs, lib, ... }:
let
  defaultHardDrive = "/dev/nvme0n1";
  nvidiaBusID = "PCI:1:0:0";
  amdgpuBusID = "PCI:69:0:0";
  ramSize = "64G";
  system = "x86_64-linux";
in
{
  imports = [
    ../../modules/partitioning
  ];
  networking.hostName = "FRACTAL-NORTH";

  hardware.nvidia = {
    amdgpuBusId = amdgpuBusID;
    nvidiaBusId = nvidiaBusID;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    powerManagement.enable = true;
    open = false;
    prime = {
      enable = true;
      enableOffloadCmd = true;
    };
    nvidiaSettings = true;
  };

  partitioning.swapSize = ramSize;
  partitioning.defaultHardDrive = defaultHardDrive;
}
