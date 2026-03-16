{ config, pkgs, ... }:

{
  # Импортируем аппаратную конфигурацию
  imports = [
    ./hardware-configuration.nix
  ];

 # Включаем поддержку Flakes и новой команды nix
  nix.settings.experimental-features = [ "nix-command" "flakes" ];


  # === ВКЛЮЧАЕМ X11 И XFCE ===
  services.xserver = {
    enable = true;
    desktopManager.xfce = {
      enable = true;
      # Если хочешь минималистичный XFCE (без доп. плагинов)
      # extraSessionCommands = ''
      #   export XDG_CURRENT_DESKTOP=XFCE
      # '';
    };
    # Для XFCE этого достаточно, displayManager не трогаем
  };

  # === НАСТРАИВАЕМ GREETD (текстовый вход) ===
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = ''
          ${pkgs.greetd.tuigreet}/bin/tuigreet 
        '';
        user = "greeter";
      };
    };
  };

  # === СПИСОК СЕССИЙ (Wayfire и другие) ===
  environment.etc."greetd/environments".text = ''
    # Wayland
    wayfire
    # dbus-launch wayfire  # если потребуется

    # Можно добавить другие:
    # sway
    # bash (для отладки)
  '';

  # === УСТАНАВЛИВАЕМ ПАКЕТЫ ===
  environment.systemPackages = with pkgs; [
    greetd.tuigreet   # текстовый интерфейс входа
    wayfire           # Wayland-композитор
    wofi              # лаунчер для Wayfire (опционально)
    swaylock          # блокировка экрана (опционально)
    foot              # терминал (для Wayfire/Sway)
    tree
    firefox
    xorg.xinit
  ];

  # === ПОЛЬЗОВАТЕЛЬ GREETER (для корректной работы Wayland) ===
  users.users.greeter = {
    isSystemUser = true;
    group = "greeter";
    home = "/var/lib/greetd";
    createHome = true;
    extraGroups = [ "video" "input" ];  # нужны для доступа к устройствам
  };
  users.groups.greeter = {};

  # === ТВОЙ ПОЛЬЗОВАТЕЛЬ (замени "твой_пользователь" на реальное имя) ===
  users.users.me = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "input" "render" ];  # video/input могут понадобиться
  };

  # Остальные твои системные настройки...
   # Поддержка графики (нужна даже для XFCE на AMD)
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  console = {
    earlySetup = true;
    font = "ter-v32n";
    packages = with pkgs; [ terminus_font ];
  };

  # База
  networking.hostName = "t14";
  networking.networkmanager.enable = true;
  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";
  nixpkgs.config.allowUnfree = true;

  # Загрузчик и ядро
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.kernelModules = [ "amdgpu" ];
  # Фикс для графики AMD Ryzen (ThinkPad T14)
  boot.kernelParams = [ "amdgpu.sg_display=0" ]; 
  
  system.stateVersion = "24.11";

}

