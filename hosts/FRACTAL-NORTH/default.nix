{ ... }: {

  imports = [
    ../../modules/partitioning
  ];

  # System information
  system = "x86_64-linux";
  networking.hostName = "FRACTAL-NORTH";

  # Nvidia drivers
  nixpkgs.config.allowUnfree = true;

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

  # Partitioning
  partitioning = {
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