{ config, pkgs, lib, disko, ... }:

{
  disko.devices = {
    disk = {
      "${config.customDriveConfiguration.target}" = {
        device = "/dev/${config.customDriveConfiguration.target}";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              name = "ESP";
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
              name = "cryptroot";
              size = "100%";
              content = {
                type = "luks";
                name = "crypted";
                settings = {
                  allowDiscards = true;
                };
                content = {
                  type = "btrfs";
                  formatOptions = {
                    mkfsOptions = [ "-f" ];
                  };
                  subvolumes = {
                    "/" = {
                      mountpoint = "/";
                      mountOptions = [ "compress=zstd" "subvol=root" "noatime" "defaults" ];
                    };
                    "/home" = {
                      mountpoint = "/home";
                      mountOptions = [ "compress=zstd" "subvol=home" "noatime" "defaults" ];
                    };
                    "/nix" = {
                      mountpoint = "/nix";
                      mountOptions = [ "compress=zstd" "noatime" "subvol=nix" "nodatacow" "defaults" ];
                    };
                    "/swap" = {
                      mountpoint = "/swap";
                      mountOptions = [ "subvol=swap" "noatime" "defaults" ];
                      swap = {
                        encrypted = {
                          enable = true;
                          device = "/swap/swapfile";
                        };
                        swapfile = {
                          size = config.customDriveConfiguration.swapSize;
                        };
                      };
                    };
                    "/var" = {
                      mountpoint = "/var";
                      mountOptions = [ "compress=zstd" "subvol=var" "noatime" "defaults" ];
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
  fileSystems."/".options = [ "defaults" "subvol=root" ];
  fileSystems."/nix".options = [ "defaults" "subvol=nix" ];
  fileSystems."/home".options = [ "defaults" "subvol=home" ];
  fileSystems."/var".options = [ "defaults" "subvol=var" ];
  fileSystems."/swap".options = [ "defaults" "subvol=swap" ];
  fileSystems."/efi".options = [ "defaults" "umask=0077" ];
}