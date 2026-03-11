{ pkgs, ... }:

{
  home-manager.users.me = {
    programs.chromium = {
      enable = true;
      # Теперь эта опция будет видна, так как она внутри Home Manager
      commandLineArgs = [
        "--ignore-gpu-blocklist"
        "--enable-gpu-rasterization"
        "--enable-zero-copy"
        "--enable-features=VaapiVideoDecodeLinuxGL"
        "--enable-features=CanvasOopRasterization"
        "--ozone-platform-hint=auto"
      ];
      extensions = [
        { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # uBlock Origin (формат HM чуть другой)
      ];
    };
  };
}
