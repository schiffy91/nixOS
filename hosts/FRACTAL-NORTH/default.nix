{ config, pkgs, lib, config ? {}, ... }:
{
  imports = [
    ../../modules/partitioning
  ];
  
  system.system = "x86_64-linux";
  networking.hostName = "FRACTAL-NORTH";

  hardware.nvidia = {
    amdgpuBusId = amdgpuBusID;
    nvidiaBusId = "PCI:69:0:0";
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    powerManagement.enable = true;
    open = false;
    prime = {
      enable = true;
      enableOffloadCmd = true;
    };
    nvidiaSettings = true;
  };

  partitioning = {
    enable = config.partitioning.enable or false;
    swapSize = "65G";
    defaultHardDrive = "/dev/nvme0n1";
  };
}
