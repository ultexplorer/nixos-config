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
    displayManager.lightdm.enable = false;
    enable = true;
    desktopManager.xfce = {
      enable = true;
      # Если хочешь минималистичный XFCE (без доп. плагинов)
      # extraSessionCommands = ''
      #   export XDG_CURRENT_DESKTOP=XFCE
      # '';
    modules = [ pkgs.xorg.xf86inputlibinput ];
    };
    # Для XFCE этого достаточно, displayManager не трогаем
  };
  services.libinput.enable = true;
  
  # === НАСТРАИВАЕМ GREETD (текстовый вход) ===

  # === СПИСОК СЕССИЙ (Wayfire и другие) ===

  # === УСТАНАВЛИВАЕМ ПАКЕТЫ ===
  environment.systemPackages = with pkgs; [
    tree
    firefox
    xorg.xinit
  ];

  # === ПОЛЬЗОВАТЕЛЬ GREETER (для корректной работы Wayland) ===

  # === ТВОЙ ПОЛЬЗОВАТЕЛЬ (замени "твой_пользователь" на реальное имя) ===
  users.users.me = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "input" "render" ];  # video/input могут понадобиться
  };
  hardware.acpilight = { 
               enable = true; 
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
  boot.kernelParams = [ "amdgpu.sg_display=0" "acpi_backlight=native" ]; 
  
  system.stateVersion = "24.11";

}

