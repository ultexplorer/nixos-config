{ config, pkgs, ... }:

let
  desktopModules = [
    ../modules/desktop/common.nix
    ../modules/desktop/xfce.nix
    ../modules/desktop/wayfire.nix
  ];
in
{
  # Имя хоста
  networking.hostName = "t14";

  # Подключаем железо (если есть hardware.nix)
  imports = [
    ./hardware.nix
  ] ++ desktopModules;

  # Системные пакеты по умолчанию
  environment.systemPackages = with pkgs; [
    vim
    git
    wget
    curl
  ];

  # Включаем sddm для выбора desktop
  services.xserver.displayManager.sddm.enable = true;

  # Разрешаем запуск X11 и Wayland
  services.xserver.enable = true;
  services.xserver.desktopManager.default = "none"; # XFCE/Wayfire через свои модули

  # Остальные системные настройки (можно расширять)
  system.stateVersion = "23.05"; # адаптируй под свою версию NixOS
}
