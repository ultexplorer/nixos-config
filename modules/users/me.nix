{ pkgs, ... }:

{
  # 1. Создаем пользователя в системе
  users.users.me = {
    isNormalUser = true;
    description = "Master of the System";
    extraGroups = [ "wheel" "networkmanager" "video" "audio" ];
    # Пароль лучше задать через `passwd` после первой загрузки
  };

  # 2. Настройки внешнего вида (Home Manager)
  home-manager.users.me = {
    home.stateVersion = "23.11";

    home.packages = with pkgs; [
      inter # Тот самый шрифт Inter из твоего конфига
      # Можно добавить другие GUI приложения здесь
    ];

    gtk = {
      enable = true;
      font.name = "Inter 11";
      theme = {
        name = "Matcha-dark-sea";
        package = pkgs.matcha-gtk-theme;
      };
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };
    };
  };
}
