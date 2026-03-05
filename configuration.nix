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
  boot.kernelParams = [
  "threadirqs"
  #"mitigations=off"
  ];


  # ===============================
  # Network
  # ===============================
  networking.networkmanager.enable = true;

  # ===============================
  # Graphics Stack (AMD Ryzen safest setup)
  # ===============================

  services.xserver.enable = true;

  ##############################################wayfire
  services.displayManager.sessionPackages = with pkgs; [
  wayfire
  ];
 
  ###################################################

  # modesetting is the most stable driver for Ryzen laptops
  services.xserver.videoDrivers = [ "modesetting" ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # ===============================
  # Display Manager
  # ===============================

  services.xserver.displayManager.lightdm.enable = true;

  # ===============================
  # Desktop Environment
  # ===============================

  services.xserver.desktopManager.xfce.enable = true;

  # ===============================
  # Power Management (important for ThinkPad Ryzen)
  # ===============================

  services.power-profiles-daemon.enable = true;

  # Prevent aggressive suspend issues
  services.logind.settings = {
    Login = {
      HandleLidSwitch = "suspend";
      HandleLidSwitchDocked = "ignore";
    };
  };

  # ===============================
  # User Setup
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
  services.upower.enable = true;
  #================================

  # ===============================
  # Base packages
  # ===============================

  environment.systemPackages = with pkgs; [
    wayfire
    pciutils
    edid-decode
    nixpkgs-fmt
    libva-utils 
    git
    vim
  ];
# -----------------------------
# Bluetooth
# -----------------------------

hardware.bluetooth = {
  enable = true;
  powerOnBoot = true;
};

services.blueman.enable = true;

boot.kernel.sysctl = {
  "vm.swappiness" = 15;
};
###################################################
console = {
    # Указываем пакет, где лежит шрифт
    packages = [ pkgs.terminus_font ];
    # Имя файла шрифта без расширения (ter-132n — это как раз оно)
    font = "ter-132n";
    # Если хочешь, чтобы в консоли работали горячие клавиши (опционально)
    useXkbConfig = true; 
  };


}
