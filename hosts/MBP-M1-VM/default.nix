{ ... }: {

  imports = [
    ../../modules/partitioning
  ];

  # System information
  system = "aarch64-linux";
  networking.hostName = "MBP-M1-VM";

  # Asahi drivers
  nixpkgs.config = {
    packageOverrides = pkgs: {
      mesa = pkgs.mesa.override {
        drivers = [ pkgs.asahi ];
      };
    };
  };
  boot.kernelPackages = pkgs.linuxPackages_asahi;

  # Partitioning
  partitioning = {
    enable = true;
    swapSize = "17G";
    defaultHardDrive = "/dev/vda";
  };
}