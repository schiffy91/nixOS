{ config, pkgs, lib, ... }:
{
  imports = [
    ../../modules/partitioning
  ];
  
  system.system = "x86_64-linux";
  networking.hostName = "FRACTAL-NORTH";

  hardware.nvidia = {
    open = false;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    nvidiaSettings = true;
    powerManagement.enable = true;
    prime = {
      enable = true;
      enableOffloadCmd = true;
      amdgpuBusId = "PCI:1:0:0";
      nvidiaBusId = "PCI:69:0:0";
    };
  };

  partitioning = config.partitioning // {
    enable = false;
    swapSize = "65G";
    defaultHardDrive = "/dev/nvme0n1";
  };
}
