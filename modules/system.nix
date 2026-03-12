{ pkgs, lib, ... }:

{
  # Локализация
  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = lib.mkDefault "Europe/Berlin"
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
    pavucontrol # Графический микшер (обязательно!)
    playerctl   # Чтобы кнопки "пауза/плей" на наушниках работали
    mpv
    tree
    psmisc
    libva-utils
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

  # 3. Сеть
  # Включаем именно сервис, а не просто пакет
  networking.networkmanager.enable = true;
  
  # Явно отключаем стандартный беспроводной демон, чтобы не мешался
 # networking.wireless.enable = false; 

  # Добавляем твоего юзера в группу, чтобы он мог управлять сетью
  users.users.me.extraGroups = [ "networkmanager" "wheel" "video" ];
  
  nix = {
    settings = {
      # Автоматическая оптимизация хранилища (ищет дубликаты файлов и делает hard links)
      # Экономит кучу места, запускаясь при каждой сборке
      auto-optimise-store = true;
    };

    gc = {
      automatic = true;      # Включаем автоматическую очистку
      dates = "weekly";      # Запуск раз в неделю (можно "daily", если часто меняешь конфиг)
      options = "--delete-older-than 7d"; # Удалять всё, что старше 7 дней
    };
  };

  # Ограничение количества поколений в меню загрузки (Bootloader)
  # Это именно то, о чем ты просил: чтобы в меню при включении не было гигантского списка
  boot.loader.grub.configurationLimit = 7; # Если у тебя GRUB
  boot.loader.systemd-boot.configurationLimit = 7; # Если у тебя systemd-boot (стандарт для UEFI)
}
