{ config, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/system.nix
    ../../modules/desktop/common.nix
    ../../modules/desktop/xfce.nix
    ../../modules/users/me.nix
    ../../modules/apps/easyeffects.nix
    ../../modules/apps/chromium.nix
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t14-amd-gen2
  ];

  networking.hostName = "t14";
  nixpkgs.config.allowUnfree = true;
  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";

  users.users.me = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" "input" ];
  };

  # Загрузка
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.initrd.kernelModules = [ "amdgpu" ];
  
  # Параметры ядра для стабильности Ryzen (против ребутов)
  boot.kernelParams = [ "processor.max_cstate=1" "amdgpu.sg_display=0" ];

  system.stateVersion = "23.11";

  # Графика AMD
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # ВХОД через greetd
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        # Запускаем tuigreet. Мы убрали жесткий dbus-run-session, 
        # так как он теперь настроен внутри модуля xfce.nix
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --user-menu --cmd startxfce4";
        user = "greeter";
      };
    };
  };

  # Wayfire (оставляем как альтернативу)
  programs.wayfire = {
    enable = true;
    plugins = with pkgs.wayfirePlugins; [ wcm wf-shell wayfire-plugins-extra ];
  };

  services.libinput.enable = true;
  
  # Настройки клавиатуры (дублируем для надежности)
  services.xserver.xkb = {
    layout = "us,ru";
    options = "grp:alt_shift_toggle";
  };

  # ВАЖНО: Мы убрали глобальные переменные Wayland, 
  # чтобы они не ломали XFCE.
  environment.sessionVariables = {
    # NIXOS_OZONE_WL = "1"; # Включишь потом только для Wayland-сессии
  };

  environment.systemPackages = with pkgs; [
    foot
    greetd.tuigreet
    # Добавь сюда xterm на всякий случай, если всё упадет — будет запасной выход
    xterm 
  ];

  # Батарея
  services.tlp.enable = true;
  services.tlp.settings = {
    START_CHARGE_THRESH_BAT0 = 75;
    STOP_CHARGE_THRESH_BAT0 = 80;
  };
}
