{ config, pkgs, lib, ... }:
{
  imports = [
    ../../modules/partitioning
  ];

  # System information
  system.system = "x86_64-linux";
  networking.hostName = "FRACTAL-NORTH";

  # Nvidia drivers
  nixpkgs.config = {
    allowUnfree = true;
    packageOverrides = pkgs: {
      nvidiaPackages = config.boot.kernelPackages.nvidiaPackages // {
        package = config.boot.kernelPackages.nvidiaPackages.stable;
      };
    };
  };
  hardware.nvidia = {
    open = false;
    nvidiaSettings = true;
    powerManagement.enable = true;
    prime = {
      enable = true;
      enableOffloadCmd = true;
      amdgpuBusId = "PCI:1:0:0";
      nvidiaBusId = "PCI:69:0:0";
    };
  };

  # Partitioning
  partitioning = config.partitioning // {
    enable = false;
    swapSize = "65G";
    defaultHardDrive = "/dev/nvme0n1";
  };

  # Virtualization (libvirt, podman)
  programs.virt-manager.enable = true;
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        ovmf.enable = true;
        ovmf.packages = [ pkgs.OVMFFull.fd ];
        swtpm.enable = true;
        runAsRoot = false;
      };
    };
    spiceUSBRedirection.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
    };
  };
}