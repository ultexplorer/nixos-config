{ pkgs, ... }:

{
  # 1. Включаем сам Wayfire на уровне системы
  programs.wayfire = {
    enable = true;
    plugins = with pkgs.wayfirePlugins; [
      wcm                 # Конфигуратор (Wayfire Config Manager)
      wf-shell            # Базовая оболочка (панель, фон)
      wayfire-plugins-extra
    ];
  };

  # 2. Явно просим Display Manager (GDM) увидеть сессию
  services.displayManager.sessionPackages = [ pkgs.wayfire ];

  # 3. Дополнительные инструменты для работы в Wayland
  environment.systemPackages = with pkgs; [
    wayland-utils
    wl-clipboard
    wf-recorder  # Запись экрана (полезно)
    slurp        # Выбор области экрана
    grim         # Скриншоты
  ];
}
