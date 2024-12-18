{ config, pkgs, lib, ... }:

{
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
              root = {
                size = "100%";
                content = {
                  format = "btrfs";
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