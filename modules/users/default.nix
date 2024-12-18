{ config, pkgs, lib, ... }:

{
  # User
  users.users.alexanderschiffhauer = {
    isNormalUser = true;
    extraGroups = [ "wheel" "libvirtd" ];
    # No initial password set
  };
}
