{ config, pkgs, lib, disko, ... }:

{
  disko.devices = {
    disk = {
      "${config.customDriveConfiguration.target}" = {
        device = "/dev/disk/${config.customDriveConfiguration.target}";
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
                          size = config.customDriveConfiguration.swapSize;
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