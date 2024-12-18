# sudo nixos-rebuild switch --flake .#FRACTAL-NORTH --option config.partitioning.enable true 
# sudo nixos-rebuild switch --flake .#MBP-M1-VM --option config.partitioning.enable true
{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, disko, lanzaboote }@inputs:
    let
      mkSystem = hostname: nixpkgs.lib.nixosSystem {
        system = (import ./hosts/${hostname}).system;
        modules = [
          ./configuration.nix
          ./hosts/${hostname}
          disko.nixosModules.default
          lanzaboote.nixosModules.lanzaboote
          {
            specialArgs = { inherit inputs; };
          }
          {
            specialArgs.diskoFormat = inputs.disko.lib.format;
          }
        ];
      };
    in
    {
      nixosConfigurations = {
        FRACTAL-NORTH = mkSystem "FRACTAL-NORTH";
        MBP-M1-VM = mkSystem "MBP-M1-VM";
      };
    };
}