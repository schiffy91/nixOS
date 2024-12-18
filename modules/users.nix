{ config, pkgs, lib, ... }:

{
  users.users.alexanderschiffhauer = {
    isNormalUser = true;
    extraGroups = [ "wheel" "libvirtd" ];
  };
}
