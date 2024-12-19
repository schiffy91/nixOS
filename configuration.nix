{ config, pkgs, lib, ... }:

let
  # Fetch disko v1.10.0 from GitHub
  disko = import (builtins.fetchTarball {
    url = "https://github.com/nix-community/disko/archive/refs/tags/v1.10.0.tar.gz";
    sha256 = "0jfasvk0hz76cipnv2mfrbgf86gcmnf0niapcm7p37xh7a0w2wxj"; # Replace with the correct hash
  }) { inherit lib; };

  # Fetch lanzaboote v0.4.1 from GitHub
  lanzaboote = import (builtins.fetchTarball {
    url = "https://github.com/nix-community/lanzaboote/archive/refs/tags/v0.4.1.tar.gz";
    sha256 = "sha256-BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB="; # Replace with the correct hash
  }) { inherit lib pkgs; };

  hostConfig = import ./hosts/${builtins.baseNameOf ./host} { inherit config pkgs lib; };
in
{
  system.stateVersion = "24.11";
  imports = [
    disko.nixosModules.disko
    lanzaboote.nixosModules.lanzaboote
    ./modules/drives.nix
    ./modules/boot.nix
    ./modules/desktop.nix
    ./modules/locale.nix
    ./modules/packages.nix
    ./modules/networking.nix
    ./modules/sound.nix
    ./modules/users.nix
    hostConfig
  ];
}