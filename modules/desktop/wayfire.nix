{ config, pkgs,lib, ... }:

{
  # Включаем Wayfire
  services.xserver.windowManager.wayfire.enable = true;

  # Wayfire специфические пакеты
  environment.systemPackages = with pkgs; [
    wayfire
    wayfire-plugins-extra
    wf-configurator
  ];
}
