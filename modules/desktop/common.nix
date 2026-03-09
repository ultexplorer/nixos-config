{ config, pkgs, ... }:

{
  # Общие звуковые сервисы
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Pipewire для Wayland и мультимедиа
  services.pipewire.enable = true;

  # Общие шрифты
  fonts.fonts = with pkgs; [
    dejavu_fonts
    liberation_ttf
  ];

  # Общие X11/Wayland настройки
  services.xserver.enable = true;
  services.xserver.desktopManager.default = "none"; # среды подключаются через свои модули
}
