{ config, lib, pkgs, disko, ... }:
with lib; 
let
  cfg = config.custom.driveConfiguration;
in {
  options.custom.driveConfiguration = {
    target = mkOption { type = types.nullOr types.str; default = null; };
    swapSize = mkOption { type = types.nullOr types.str; default = null; };
  };
  config = mkIf (cfg.target != null && cfg.swapSize != null) {
    disko.devices = {
      disk = {
        main = {
          type = "disk";
          device = "/dev/${cfg.target}";
          content = {
            type = "gpt";
            partitions = {
              ESP = {
                size = "512M";
                type = "EF00";
                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot";
                  mountOptions = [ "umask=0077" ];
                };
              };
              luks = {
                size = "100%";
                content = {
                  type = "luks";
                  name = "crypted";
                  # disable settings.keyFile if you want to use interactive password entry
                  #passwordFile = "/tmp/secret.key"; # Interactive
                  settings = {
                    allowDiscards = true;
                    keyFile = "/tmp/secret.key";
                  };
                  additionalKeyFiles = [ "/tmp/additionalSecret.key" ];
                  content = {
                    type = "btrfs";
                    extraArgs = [ "-f" ];
                    subvolumes = {
                      "/root" = {
                        mountpoint = "/";
                        mountOptions = [ "compress=zstd" "noatime" ];
                      };
                      "/home" = {
                        mountpoint = "/home";
                        mountOptions = [ "compress=zstd" "noatime" ];
                      };
                      "/nix" = {
                        mountpoint = "/nix";
                        mountOptions = [ "compress=zstd" "noatime" ];
                      };
                      "/swap" = {
                        mountpoint = "/.swapvol";
                        swap.swapfile.size = cfg.swapSize;
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