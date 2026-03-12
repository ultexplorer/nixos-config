{ pkgs, ... }: {
  home-manager.users.me = {
    programs.chromium = {
      enable = true;
      # package = pkgs.chromium; # Эту строку можно закомментировать, если она есть
      commandLineArgs = [
        "--ignore-gpu-blocklist"
        "--ozone-platform-hint=auto"
        "--enable-gpu-rasterization"
        "--enable-zero-copy"
        "--enable-features=VaapiVideoDecoder,VaapiVideoEncoder,VaapiVideoDecodeLinuxGL,CanvasOopRasterization"
      ];
    };
  };
}
