{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    disko.url = "github:nix-community/disko";
  };

  outputs = { self, nixpkgs, disko }@inputs:
    let
      mkSystem = hostname: overlay:
        let
          hostModule = import ./hosts/${hostname};
          system = hostModule.system;
          pkgs = import nixpkgs {
            inherit system;
            overlays = [ overlay ];
          };
        in
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit pkgs; };
          modules = [
            ./configuration.nix
            hostModule
            disko.nixosModules.default
            # Apply the overlay to the configuration as a module
            {
              nixpkgs.overlays = [ overlay ];
            }
          ];
        };
    in
    {
      nixosConfigurations = {
        FRACTAL-NORTH = mkSystem "FRACTAL-NORTH" (self: super: {});
        FRACTAL-NORTH-PARTITIONED = mkSystem "FRACTAL-NORTH" (import ./overlays/partitioning-overlay.nix);
        MBP-M1-VM = mkSystem "MBP-M1-VM" (self: super: {});
        MBP-M1-VM-PARTITIONED = mkSystem "MBP-M1-VM" (import ./overlays/partitioning-overlay.nix);
      };
    };
}