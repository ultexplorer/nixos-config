{ inputs, myUser, ... }: # Принимаем переменную из flake.nix

{
  imports = [
    # 1. Железо
    ./hardware-configuration.nix
    
    # 2. Общие системные настройки
    ../../modules/common.nix
    ../../modules/system/hardware.nix
    ../../modules/system/xfce.nix
    
    # 3. Подключение Home Manager как модуля
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      
      # Передаем переменную myUser внутрь Home Manager
      home-manager.extraSpecialArgs = { inherit myUser; };
      
      # Указываем, какой файл использовать для настроек пользователя
      home-manager.users.${myUser} = import ../../modules/home/default.nix;
    }
  ];

  networking.hostName = "t14";
  system.stateVersion = "24.11";
}
