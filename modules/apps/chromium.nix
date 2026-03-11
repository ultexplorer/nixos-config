{ pkgs, ... }:

{
  programs.chromium = {
    enable = true;
    # Флаги для аппаратного ускорения на AMD/Wayland/X11
    commandLineArgs = [
      "--ignore-gpu-blocklist"
      "--enable-gpu-rasterization"
      "--enable-zero-copy"
      "--enable-features=VaapiVideoDecodeLinuxGL"
      "--enable-features=CanvasOopRasterization"
      "--ozone-platform-hint=auto" # Поможет при переходе на Niri (Wayland)
    ];
    extensions = [
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" # uBlock Origin
    ];
  };
}
