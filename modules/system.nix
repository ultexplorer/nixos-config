{ pkgs, lib, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Локализация
  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = lib.mkDefault "Europe/Berlin"; # Была пропущена ;

  # Настройка консоли (TTY)
  console = {
    font = "ter-v32n";
    packages = [ pkgs.terminus_font ];
    keyMap = "us";
  };

  # Шрифты для системы (GUI)
  fonts.packages = with pkgs; [
    terminus_font
  ];

  # Общие пакеты
  environment.systemPackages = with pkgs; [
    vim
    mc
    git
    wget
    curl
    htop
    pciutils
    usbutils
    pavucontrol
    playerctl
    mpv
    tree
    psmisc
    libva-utils
  ];
 
  # 1. Включаем Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        Experimental = true;
      };
    };
  };
  services.blueman.enable = true;

  # 2. Звук через Pipewire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  # 3. Сеть
  networking.networkmanager.enable = true;

  # Добавляем твоего юзера в группы
  users.users.me.extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
 
  nix = {
    settings = {
      auto-optimise-store = true;
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  # Ограничение количества поколений в меню загрузки
  boot.loader.grub.configurationLimit = 7;
  boot.loader.systemd-boot.configurationLimit = 7;


}
