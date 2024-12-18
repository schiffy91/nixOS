{ config, pkgs, lib, ... }: 

{
  # System information
  system = "x86_64-linux";
  networking.hostName = "FRACTAL-NORTH";

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

  # Partitioning
  partitioning = {
    swapSize = "65G";
    target = "/dev/nvme0n1";
  };

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