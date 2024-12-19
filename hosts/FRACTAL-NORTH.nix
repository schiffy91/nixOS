{ config, pkgs, lib, ... }:

let
  cfg = config.custom;
in
{
  # System information
  networking.hostName = "FRACTAL-NORTH";

  # Partitioning
  cfg.driveConfiguration = {
    swapSize = "65G";
    target = "nvme0n1";
  };

  # Nvidia drivers
  nixpkgs.overlays = [
    (self: super: {
      nvidiaPackages = super.nvidiaPackages.override {
        config = { allowUnfree = true; };
      };
      hardware.nvidia = {
        open = false;
        package = self.nvidiaPackages.stable;
        nvidiaSettings = true;
        powerManagement.enable = true;
        prime = {
          enable = true;
          enableOffloadCmd = true;
          amdgpuBusId = "PCI:1:0:0";
          nvidiaBusId = "PCI:69:0:0";
        };
      };
    })
  ];

  # Virtualization (libvirt, podman)
  programs.virt-manager.enable = true;
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu;
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