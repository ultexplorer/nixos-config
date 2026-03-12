{ pkgs, ... }:

{
  home-manager.users.me = {
    programs.chromium = {
      enable = true;
      # Самый надежный способ для Home Manager
      extensions = [
        { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # uBlock Origin
        { id = "omkfmpieigblcllmkgbflkikinpkhlkg"; } # enhanced-h264ify
      ];
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
