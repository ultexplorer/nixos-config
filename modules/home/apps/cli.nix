{ pkgs, ... }:

{
  home.packages = with pkgs; [
    htop
    mc
    git
    vim
    w3m
    aerc
    tree
    wget
    curl
    smartmontools
    lm_sensors
    powertop
    pciutils
    edid-decode
    libva-utils
    yt-dlp
  ];
}
