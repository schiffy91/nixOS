{ config, pkgs, lib, ... }:

{
  # Nvidia drivers
  hardware.nvidia = {
    # These options are now set in hosts/FRACTAL-NORTH/default.nix
    # and passed down to this module
    inherit (config.hardware.nvidia) prime;
    inherit (config.hardware.nvidia) amdgpuBusId;
    inherit (config.hardware.nvidia) nvidiaBusId;
    inherit (config.hardware.nvidia) nvidiaSettings;
    inherit (config.hardware.nvidia) package;
    inherit (config.hardware.nvidia) powerManagement;
    inherit (config.hardware.nvidia) open;
  };
}
