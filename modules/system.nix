{ pkgs, ... }:

{
  # Локализация
  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "Europe/Berlin"; # Настрой под себя

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

  # Общие пакеты, которые нужны везде (даже на сервере)
  environment.systemPackages = with pkgs; [
    vim
    mc
    git
    wget
    curl
    htop
    pciutils # Чтобы смотреть железо через lspci
    usbutils # Чтобы видеть твою будущую клавиатуру через lsusb
  ];
  
  # 1. Включаем Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true; # Чтобы наушники цеплялись сразу при включении
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        Experimental = true; # Помогает с отображением заряда батареи наушников
      };
    };
  };
  services.blueman.enable = true;

  # 2. Звук через Pipewire (необходим для современных наушников)
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    # Это позволит управлять звуком наушников через стандартные утилиты
  };

  # 3. Утилиты для управления
  environment.systemPackages = with pkgs; [
    pavucontrol # Графический микшер (обязательно!)
    playerctl   # Чтобы кнопки "пауза/плей" на наушниках работали
  ];

}
