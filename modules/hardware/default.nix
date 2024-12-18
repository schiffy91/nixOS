{ config, pkgs, lib, ... }:

{
  imports = [
    ./gpu.nix
  ];

  # Placeholder options for hardware-specific variables
  # (defined in hosts/FRACTAL-NORTH/default.nix)
  options = {
    hardware.nvidia = {
      nvidiaBusId = lib.mkOption {
        type = lib.types.str;
        default = "";
        description = "PCI bus ID of the Nvidia GPU";
      };
      amdgpuBusId = lib.mkOption {
        type = lib.types.str;
        default = "";
        description = "PCI bus ID of the AMD GPU";
      };
      prime = {
        enable = lib.mkEnableOption "Enable NVIDIA Prime";
        enableOffloadCmd = lib.mkEnableOption "Enable NVIDIA Prime offload command";
      };
      nvidiaSettings = lib.mkEnableOption "Enable NVIDIA settings";
      package = lib.mkOption {
        type = lib.types.package;
        description = "NVIDIA driver package to use";
      };
      powerManagement.enable = lib.mkEnableOption "Enable NVIDIA power management";
      open = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable open-source NVIDIA kernel modules";
      };
    };
  };
}
