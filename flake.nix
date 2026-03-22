{
  description = "My T14 NixOS Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: 
    let
      # === ВОТ ОНО! ЗАДАЕМ ИМЯ ОДИН РАЗ ЗДЕСЬ ===
      myUser = "igor"; 
      system = "x86_64-linux";
    in {
      nixosConfigurations.t14 = nixpkgs.lib.nixosSystem {
        inherit system;
        # Передаем переменную внутрь всех .nix файлов
        specialArgs = { inherit inputs myUser; }; 
        modules = [ ./hosts/t14/default.nix ];
      };
    };
}
