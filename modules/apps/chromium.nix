{ pkgs, ... }:

{
  home-manager.users.me = {
    programs.chromium = {
      enable = true;
      commandLineArgs = [
        # Ускорение GPU и обход блокировок (для AMD в Linux)
        "--ignore-gpu-blocklist"
        "--enable-gpu-rasterization"
        "--enable-zero-copy"
        
        # Интеграция с Wayland и видео-ускорение
        "--ozone-platform-hint=auto"
        "--enable-features=VaapiVideoDecoder,VaapiVideoEncoder,VaapiVideoDecodeLinuxGL,CanvasOopRasterization"
      ];
      
      # Расширения ставим руками в самом браузере — так надежнее.
      # Секцию extensions и extraOpts удаляем для чистоты.
    };
  };
}
