{ config, pkgs, lib, ... }:

{
  # Desktop Environment (Plasma 6)
  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.displayManager = {
    sddm.enable = true;
    wayland.enable = true;
    autoLogin = {
      enable = true;
      user = "alexanderschiffhauer";
    };
  };
}
