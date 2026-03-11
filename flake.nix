{
  description = "NixOS configuration for ThinkPad T14";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-hardware, home-manager, ... }@inputs: 
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      # overlays = [ (import ./overlays/default.nix) ]; # Разблокируй, если файл уже есть
    };
  in {
     nixosConfigurations.t14 = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/t14/default.nix
        home-manager.nixosModules.home-manager # Добавляем эту строку
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
        }
      ];
    };
    };

    # Оставляем devShells, если они тебе нужны
    devShells.${system}.default = import ./devshells/default.nix { inherit pkgs; };
  };
}
