{ config, pkgs, ... }:

{
  # Включаем XFCE
  services.xserver.desktopManager.xfce.enable = true;

  # Включаем sddm для выбора среды
  services.xserver.displayManager.sddm.enable = true;

  # XFCE специфические пакеты
  environment.systemPackages = with pkgs; [
    xfce4
    xfce4-terminal
    thunar
    mousepad
  ];
}
