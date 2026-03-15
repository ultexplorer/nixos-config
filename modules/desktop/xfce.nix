{ pkgs, ... }:

{
  # 1. Основные службы графики
  services.xserver = {
    enable = true;
    # Настройка раскладки (сделай под себя, если нужно)
    xkb.layout = "us,ru";
    xkb.options = "grp:alt_shift_toggle";
    
    # Включаем XFCE на системном уровне
    desktopManager.xfce.enable = true;
  };

  # 2. Исправляем ошибку "NameHasNoOwner" из dbus-monitor
  # Порталы нужны, чтобы XFCE мог общаться с системой (темы, файлы, диалоги)
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "gtk";
  };

  # 3. "Нервная система" (D-Bus) и системные службы
  services.dbus.enable = true;
  
  # Чтобы в XFCE работали флешки, корзина и управление питанием
  services.gvfs.enable = true;    # Монтирование дисков
  services.tumbler.enable = true; # Превью картинок в Thunar
  services.upower.enable = true;  # Индикатор батареи и сон
  
  # Позволяет менять настройки яркости и звука без sudo
  security.polkit.enable = true;

  # 4. Шрифты (чтобы интерфейс XFCE не выглядел как каша из квадратиков)
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-emoji
    liberation_ttf
    fira-code
    jetbrains-mono
  ];

  # 5. Добавляем системные пакеты, специфичные для XFCE
  environment.systemPackages = with pkgs; [
    xfce.xfce4-pulseaudio-plugin # Громкость на панели
    xfce.xfce4-netload-plugin    # Монитор сети
    xfce.thunar-archive-plugin   # Работа с архивами
    pavucontrol                  # Настройка звука
    light                        # Управление подсветкой
  ];
}
