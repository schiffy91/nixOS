{ config, pkgs, lib, ... }:
let
  inherit (lib) mkOption mkIf types;
in
{
  options = {
    partitioning = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = "Enable automatic partitioning";
      };
      defaultHardDrive = mkOption {
        type = types.str;
        default = "";
        description = "Default hard drive to use for partitioning";
      };
      swapSize = mkOption {
        type = types.str;
        default = "16G";
        description = "Size of the swap file";
      };
    };
  };

  config = mkIf config.partitioning.enable {
    disko.devices = {
      disk = {
        # Use the defaultHardDrive variable passed from hosts/FRACTAL-NORTH/default.nix
        "${config.partitioning.defaultHardDrive}" = {
          type = "disk";
          content = {
            type = "gpt";
            partitions = {
              ESP = {
                size = "512M";
                type = "EF00";
                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/efi";
                  mountOptions = [
                    "defaults"
                    "umask=0077"
                  ];
                };
              };
              root = {
                size = "100%";
                content = {
                  type = "btrfs";
                  extraArgs = [ "-f" ];
                  subvolumes = {
                    "/" = {
                      mountpoint = "/";
                      mountOptions = [ "compress=zstd" "subvol=root" "noatime" ];
                    };
                    "/home" = {
                      mountpoint = "/home";
                      mountOptions = [ "compress=zstd" "subvol=home" "noatime" ];
                    };
                    "/nix" = {
                      mountpoint = "/nix";
                      mountOptions = [ "compress=zstd" "noatime" "subvol=nix" "nodatacow" ];
                    };
                    "/.swapvol" = {
                      mountpoint = "/.swapvol";
                      mountOptions = [ "subvol=swap" "noatime" ];
                      swap = {
                        swapfile = {
                          # Use swapSize variable from FRACTAL-NORTH
                          size = config.partitioning.swapSize;
                        };
                      };
                    };
                    "/var" = {
                      mountpoint = "/var";
                      mountOptions = [ "compress=zstd" "subvol=var" "noatime" ];
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
