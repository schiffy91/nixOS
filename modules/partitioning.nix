{ config, pkgs, lib, ... }:

{
  options.partitioning = with lib; {
    target = mkOption { type = types.nullOr types.str; default = null; };
    swapSize = mkOption { type = types.nullOr types.str; default = null; };
  };
  config = lib.mkIf (config.partitioning.target != null && config.partitioning.swapSize != null) {
    disko.devices = {
      disk = {
        "${config.partitioning.target}" = {
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
              cryptroot = {
                size = "100%";
                content = {
                  type = "luks";
                  name = "cryptroot";
                  settings = {
                    allowDiscards = true;
                  };
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
                          encrypted = {
                            enable = true;
                            device = "/.swapvol/swapfile";
                          };
                          swapfile = {
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
  };
}