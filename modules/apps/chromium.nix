{ pkgs, ... }:

{
  home-manager.users.me = {
    programs.chromium = {
      enable = true;
      # Теперь эта опция будет видна, так как она внутри Home Manager
      commandLineArgs = [
        "--ignore-gpu-blocklist"
        "--ozone-platform-hint=auto"
        "--enable-features=VaapiVideoDecoder,VaapiVideoEncoder" # Добавили Encoder
        "--enable-gpu-rasterization"
        "--enable-zero-copy"
      ];

      extensions = [
        { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # uBlock Origin (формат HM чуть другой)
      ];
    };
  };
}
