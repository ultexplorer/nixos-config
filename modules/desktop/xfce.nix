{ pkgs, ... }:

{
  services.xserver.enable = true;
  services.xserver.desktopManager.xfce.enable = true;

  # Эти пакеты будут доступны в системе только когда включен этот модуль
  environment.systemPackages = with pkgs; [
    xfce.xfce4-whiskermenu-plugin
    xfce.xfce4-pulseaudio-plugin
    xfce.xfce4-terminal
    papirus-icon-theme # Дублируем здесь или в me.nix, чтобы XFCE их видел
  ];
}
