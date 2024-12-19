{ config, pkgs, lib, ... }:

{
  options.customDriveConfiguration = with lib; {
    target = mkOption { type = types.nullOr types.str; default = null; };
    swapSize = mkOption { type = types.nullOr types.str; default = null; };
  };
}