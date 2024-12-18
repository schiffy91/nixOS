{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    disko.url = "github:nix-community/disko";
  };

  outputs = { self, nixpkgs, disko }@inputs:
    let
      mkSystem = hostname: system: config: nixpkgs.lib.nixosSystem {
        system = system;
        specialArgs = {
          inherit config;
        };
        modules = [
          ./configuration.nix
          ./hosts/${hostname}
          disko.nixosModules.default
        ];
      };
    in
    {
      nixosConfigurations = {
        FRACTAL-NORTH = mkSystem "FRACTAL-NORTH" "x86_64-linux" {};
        MBP-M1-VM = mkSystem "MBP-M1-VM" "aarch64-linux" {};
      };
    };
}