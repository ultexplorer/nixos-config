{ description = "NixOS configuration for ThinkPad T14";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    home-manager.url = "github:nix-community/home-manager";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, nixos-hardware, home-manager, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; overlays = [ (import ./overlays/default.nix) ]; };
      in
      {
        # Основная конфигурация для твоей машины
        nixosConfigurations = {
          t14 = pkgs.lib.nixosSystem {
            inherit system;
            modules = [
              ./hosts/t14/default.nix
            ];
            # specialArgs = { inherit inputs; }; <- удаляем или заменяем на self
            specialArgs = { inherit self; }; # <-- если нужно передавать flake
          };
        };

        # DevShell для разработки
        devShells.${system}.default = import ./devshells/default.nix { inherit pkgs; };
      }
    );
}
