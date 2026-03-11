{ config, pkgs, inputs, ... }:

{
  imports = [
     ./hardware-configuration.nix     # Железо конкретно этого ноута
    ../../modules/system.nix           # База (шрифты, консоль, git)
    ../../modules/desktop/common.nix # Общее для GUI (звук, видео)
    ../../modules/desktop/xfce.nix   # Конкретно оболочка XFCE
    ../../modules/users/me.nix
    ../../modules/apps/easyeffects.nix
    ../../modules/apps/chromium.nix
    # Если у тебя AMD версия T14:
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t14-amd-gen2 # Вот этот модуль специально для тебя
  ];

  networking.hostName = "t14";

  # Здесь твои базовые настройки
  time.timeZone = "Europe/Berlin"; # Или твой пояс
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

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
     # amdvlk # Драйвер Vulkan от AMD
     # vaapiVdpau
      libva-vdpau-driver
      libvdpau-va-gl
    ];
  };

  # Настройки TLP для батареи ThinkPad
  services.tlp.enable = true;
  services.tlp.settings = {
    START_CHARGE_THRESH_BAT0 = 75;
    STOP_CHARGE_THRESH_BAT0 = 80;
  };
  

}
