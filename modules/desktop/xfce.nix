{ pkgs, ... }:

{
  # 1. Включаем сам X-сервер и XFCE
  services.xserver = {
    enable = true;
    desktopManager.xfce.enable = true;
    displayManager.lightdm.enable = true; # Или твой greetd/tuigreet
  };

  # 2. Настраиваем порталы (то, на что ругался dbus-monitor)
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "gtk";
  };

  # 3. Важные системные службы для связи компонентов
  services.dbus.enable = true;
  
  # Это поможет XFCE управлять питанием и монтировать диски
  services.upower.enable = true;
  services.gvfs.enable = true; # Для работы с файлами и корзиной
  services.tumbler.enable = true; # Для превью картинок
}

