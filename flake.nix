{ description = "NixOS configuration for ThinkPad T14";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    home-manager.url = "github:nix-community/home-manager";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, home-manager, flake-utils, ... }:
  flake-utils.lib.eachDefaultSystem (system:
    let
      pkgs = import nixpkgs { inherit system; overlays = [ (import ./overlays/default.nix) ]; };
    in
    {
      nixosConfigurations = {
        t14 = pkgs.lib.nixosSystem {
          inherit system;
          modules = [ ./hosts/t14/default.nix ];
        };
      };

      devShells.${system}.default = import ./devshells/default.nix { inherit pkgs; };

      # <--- Добавляем атрибут home-manager для nix run
      home-manager = {
        type = "app";
        program = "${home-manager}/bin/home-manager";
      };
    }
  );
  
}
