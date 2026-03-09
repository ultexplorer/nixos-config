{
  description = "Ultexplorer NixOS configuration with hardware optimizations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware";
  };

  outputs = { self, nixpkgs, home-manager, nixos-hardware, ... }@inputs:

  let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [ (import ./overlays) ];
    };
  in
  {

    nixosConfigurations = {

      t14 = nixpkgs.lib.nixosSystem {
        inherit system;

        modules = [
          # hardware optimizations для ThinkPad T14
          (import "${nixos-hardware}/nixos/laptops/lenovo/t14") 

          ./hosts/t14

          # Home Manager integration
          home-manager.nixosModules.home-manager

          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.ultexplorer =
              import ./home/user.nix;
          }
        ];
      };

    };

    # devShell для разработки
    devShells.${system}.default =
      import ./devshells/default.nix { inherit pkgs; };
  };
}
