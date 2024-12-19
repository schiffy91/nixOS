{
  description = "My NixOS System Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    disko = {
      url = "github:nix-community/disko/v1.10.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, disko, lanzaboote }:
    let
      pkgs = import nixpkgs {
        config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations = {
        "MBP-M1-VM" = nixpkgs.lib.nixosSystem {
          inherit pkgs;
          specialArgs = { inherit disko lanzaboote; };
          modules = [
            ./configuration.nix
            ./hosts/MBP-M1-VM.nix 
            disko.nixosModules.disko
            lanzaboote.nixosModules.default
          ];
        };
        "FRACTAL-NORTH" = nixpkgs.lib.nixosSystem {
            inherit pkgs;
            specialArgs = { inherit disko lanzaboote; };
            modules = [
                ./configuration.nix
                ./hosts/FRACTAL-NORTH.nix
                disko.nixosModules.disko
                lanzaboote.nixosModules.default
            ];
        };
      };
    };
}