{ ... }: {

  imports = [
    ../../modules/partitioning
  ];

  # System information
  system = "aarch64-linux";
  networking.hostName = "MBP-M1-VM";

  # Asahi drivers
  nixpkgs.overlays = [
    (self: super: {
      mesa = super.mesa.override {
        drivers = [ super.asahi ];
      };
    })
  ];
  boot.kernelPackages = pkgs.linuxPackages_asahi;

  # Partitioning
  partitioning = {
    enable = true;
    swapSize = "17G";
    defaultHardDrive = "/dev/vda";
  };
}