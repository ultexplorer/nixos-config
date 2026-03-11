{ config, pkgs, ... }:

{
  # Включаем XFCE
  services.xserver.desktopManager.xfce.enable = true;

  # XFCE специфические пакеты
  environment.systemPackages = with pkgs; [
    xfce4
    xfce4-terminal
    thunar
    mousepad
  ];
}
