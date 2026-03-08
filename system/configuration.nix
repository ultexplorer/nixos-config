{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  # ПОПРАВЛЕНО: Ставим актуальную версию (24.11 для стабильной)
  system.stateVersion = "24.11"; 

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 5;
  boot.kernelParams = [ "threadirqs" ];

  networking.networkmanager.enable = true;

  # ===============================
  # Graphics Stack & Desktop
  # ===============================
  
  services.xserver = {
    enable = true;
    videoDrivers = [ "modesetting" ];
    
    # ВОТ ЗДЕСЬ ИСПРАВЛЕНИЕ: добавили xfce внутрь xserver
    desktopManager.xfce.enable = true;
    
    displayManager.gdm.enable = true;
  };

  services.displayManager.defaultSession = "xfce";

  
  # Включаем Wayfire правильно
  programs.wayfire.enable = true; 

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # ===============================
  # Power, Users & Bluetooth
  # ===============================
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

  users.users.me = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "networkmanager" "input" ];
  };

  security.sudo.enable = true;

  environment.systemPackages = with pkgs; [
    # Wayfire уже включен через programs.wayfire.enable
    nixpkgs-fmt
    git
    vim
    mc
    foot # Терминал для Wayfire, он тебе пригодится
  ];

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;
  services.blueman.enable = true;

  boot.kernel.sysctl = { "vm.swappiness" = 15; };

  # ===============================
  # Console & Fonts
  # ===============================
  console = {
    font = "ter-v32n";
    packages = [ pkgs.terminus_font ];
    keyMap = "us";
  };

  fonts.packages = with pkgs; [
    terminus_font
    noto-fonts
    noto-fonts-color-emoji
  ];
}
