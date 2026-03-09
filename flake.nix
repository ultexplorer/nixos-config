{
  description = "NixOS configuration for ThinkPad T14";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    home-manager.url = "github:nix-community/home-manager";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, home-manager, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ (import ./overlays/default.nix) ];
        };
      in
      {
        # Основная конфигурация NixOS
        nixosConfigurations = {
          t14 = pkgs.nixosSystem {
            inherit system;
            modules = [
              ./hosts/t14/default.nix
            ];
            # configuration = {}; # опционально, не обязательно
          };
        };

        # DevShell для разработки
        devShells.${system}.default = import ./devshells/default.nix { inherit pkgs; };

        # Home-manager
        packages.home-manager = home-manager.packages.${system}.home-manager;
      }
    );
}
