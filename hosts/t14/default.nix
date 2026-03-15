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
  system.stateVersion = "23.11";

  # Графика AMD
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # ВХОД (Минимализм)
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
       command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --user-menu --cmd 'dbus-run-session startxfce4'";
      };
    };
  };

  # Wayfire и ввод
  programs.wayfire = {
    enable = true;
    plugins = with pkgs.wayfirePlugins; [ wcm wf-shell wayfire-plugins-extra ];
  };

  services.libinput.enable = true;
  services.xserver.xkb = {
    layout = "us,ru";
    options = "grp:alt_shift_toggle";
  };

  # Переменные для Chromium и Wayland
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    XDG_CURRENT_DESKTOP = "Wayfire";
    XDG_SESSION_TYPE = "wayland";
    GDK_BACKEND = "wayland";
  };

  environment.systemPackages = with pkgs; [
    foot
    greetd.tuigreet
  ];

  # Батарея
  services.tlp.enable = true;
  services.tlp.settings = {
    START_CHARGE_THRESH_BAT0 = 75;
    STOP_CHARGE_THRESH_BAT0 = 80;
  };
}
