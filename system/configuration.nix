{ config, pkgs, ... }:

{
  # ===============================
  # Imports
  # ===============================
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
  services.xserver = {
    enable = true;
    videoDrivers = [ "modesetting" ];

    displayManager = {
      lightdm.enable = false;
      gdm.enable = true;
      defaultSession = "xfce";
      sessionPackages = with pkgs; [ wayfire ];
    };

    desktopManager.xfce.enable = true;
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

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

  # ===============================
  # Sudo
  # ===============================
  security.sudo.enable = true;

  # ===============================
  # Packages
  # ===============================
  environment.systemPackages = with pkgs; [
    wayfire
    nixpkgs-fmt
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
