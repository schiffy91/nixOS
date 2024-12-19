{ config, lib, pkgs, ... }:

{
  users.users.alexanderschiffhauer = {
    isNormalUser = true;
    extraGroups = [ "wheel" "libvirtd" ];
  };
}
