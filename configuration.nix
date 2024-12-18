./configuration.nix
{ config, pkgs, lib, ... }:

let
  lanzabooteSrc = builtins.fetchTarball { url = "https://github.com/nix-community/lanzaboote/archive/refs/tags/v0.4.1.tar.gz"; };
  lanzaboote = import "${lanzabooteSrc}/nixosModules/default.nix" { inherit pkgs lib; };
  hostConfig = import ./hosts/${"MBP-M1-VM"}.nix { inherit config pkgs lib; };
  partition = true;
in
{
  imports = [
    ./modules/boot
    ./modules/desktop
    ./modules/locale
    ./modules/packages
    ./modules/networking
    ./modules/sound
    ./modules/users
    hostConfig
    lanzaboote
  ] ++ (lib.optionals partition [ ./modules/partitioning ]);
  system.stateVersion = "24.11";
}