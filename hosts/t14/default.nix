{ config, pkgs, inputs, ... }:

{
  imports = [
     ./hardware-configuration.nix     # Железо конкретно этого ноута
    ../../modules/system.nix           # База (шрифты, консоль, git)
    ../../modules/desktop/common.nix # Общее для GUI (звук, видео)
    ../../modules/desktop/xfce.nix   # Конкретно оболочка XFCE
    # Если у тебя AMD версия T14:
   # inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t14-gen1-amd
  ];

  networking.hostName = "t14";

  # Здесь твои базовые настройки
  time.timeZone = "Europe/Moscow"; # Или твой пояс
  i18n.defaultLocale = "en_US.UTF-8";

  # Не забудь про юзера, чтобы не остаться снаружи!
  users.users.me = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  # Настройки загрузчика для UEFI
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  system.stateVersion = "23.11"; 
}
