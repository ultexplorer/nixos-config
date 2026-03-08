{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "25.11";

  # ===============================
  # Bootloader (UEFI)
  # ===============================

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 5;

  boot.kernelParams = [
    "threadirqs"
    # "mitigations=off"
  ];

  # ===============================
  # Network
  # ===============================

  networking.networkmanager.enable = true;

  # ===============================
  # Graphics Stack
  # ===============================

  services.xserver.enable = true;

  services.xserver.videoDrivers = [ "modesetting" ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # ===============================
  # Display Manager
  # ===============================

  services.xserver.displayManager.lightdm.enable = false;
  # Включаем GDM
  services.xserver.displayManager.gdm.enable = true;

  # Опционально: задать default session
  services.xserver.displayManager.defaultSession = "xfce";

  # ===============================
  # Desktop Environment
  # ===============================

  services.xserver.desktopManager.xfce.enable = true;

  # ===============================
  # Wayfire (если хочешь запускать как сессию)
  # ===============================

  services.displayManager.sessionPackages = with pkgs; [
    wayfire
  ];

  # ===============================
  # Power Management
  # ===============================

  services.power-profiles-daemon.enable = true;

  services.logind.settings = {
    Login = {
      HandleLidSwitch = "suspend";
      HandleLidSwitchDocked = "ignore";
    };
  };

  services.upower.enable = true;

  # ===============================
  # Users
  # ===============================

  users.users.me = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "video"
      "audio"
      "networkmanager"
      "input"
    ];
  };

  security.sudo.enable = true;

  # ===============================
  # Packages
  # ===============================

  environment.systemPackages = with pkgs; [
    tree
    smartmontools
    lm_sensors
    powertop
    htop
    w3m
    mc
    links2
    aerc
    wayfire
    pciutils
    edid-decode
    nixpkgs-fmt
    libva-utils
    git
    vim
  ];

  # ===============================
  # Bluetooth
  # ===============================

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  services.blueman.enable = true;

  # ===============================
  # Kernel tuning
  # ===============================

  boot.kernel.sysctl = {
    "vm.swappiness" = 15;
  };

  # ===============================
  # Console
  # ===============================

  console = {
    font = "ter-v32n";
    packages = [ pkgs.terminus_font ];
    keyMap = "us";
  };

  # ===============================
  # Fonts
  # ===============================

  fonts.packages = with pkgs; [
    terminus_font
    noto-fonts
    noto-fonts-color-emoji
  ];

}
