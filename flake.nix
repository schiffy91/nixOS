{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    disko.url = "github:nix-community/disko";
  };

  outputs = { self, nixpkgs, disko }@inputs:
    let
      mkSystem = hostname: {
        nixpkgs.lib.nixosSystem {
          system = (import ./hosts/${hostname}).system;
          modules = [
            ./configuration.nix
            ./hosts/${hostname}
            disko.nixosModules.default
          ];
        };
      };
    in
    {
      nixosConfigurations = {
        # Define your NixOS configurations here
        FRACTAL-NORTH = mkSystem "FRACTAL-NORTH";
        FRACTAL-NORTH-PARTITIONED = mkSystem "FRACTAL-NORTH";
        MBP-M1-VM = mkSystem "MBP-M1-VM";
        MBP-M1-VM-PARTITIONED = mkSystem "MBP-M1-VM";
      };
    };
}