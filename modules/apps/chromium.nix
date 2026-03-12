{ pkgs, ... }:

{
  home-manager.users.me = {
    programs.chromium = {
      enable = true;
      
      # 1. Твои очищенные флаги (без дублей)
      commandLineArgs = [
        "--ignore-gpu-blocklist"
        "--ozone-platform-hint=auto"
        "--enable-gpu-rasterization"
        "--enable-zero-copy"
        "--enable-features=VaapiVideoDecoder,VaapiVideoEncoder,VaapiVideoDecodeLinuxGL,CanvasOopRasterization"
      ];

      # 2. Силовой метод установки (через политики Google)
      extraOpts = {
        "ExtensionInstallForcelist" = [
          "cjpalhdlnbpafiamejdnhcphjbkeiagm;https://clients2.google.com/service/update2/crx"
          "omkfmpieigblcllmkgbflkikinpkhlkg;https://clients2.google.com/service/update2/crx"
        ];
      };
    };
  };
}
