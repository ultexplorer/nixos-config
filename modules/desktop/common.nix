{ config, pkgs, lib, ... }:

{
  # 1. Настройка звука (Pipewire — современный стандарт)
  security.rtkit.enable = true; # Нужно для работы Pipewire с приоритетом
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # Если хочешь использовать старые программы для JACK:
    jack.enable = true;
  };

  # 2. Шрифты (используем актуальный синтаксис)
  fonts.packages = with pkgs; [
    dejavu_fonts
    liberation_ttf
    noto-fonts
    noto-fonts-color-emoji
    font-awesome # Полезно для статус-баров в Niri/Wayfire
  ];

  # 3. Графический стек
  services.xserver.enable = true;
  
  # Отключаем дефолтные "заглушки", чтобы они не мешали твоим XFCE или Wayfire
  services.xserver.desktopManager.xterm.enable = false;
  
  # Чтобы работал Wayland-композитор, часто нужно включить это:
  # programs.xwayland.enable = true;


}
