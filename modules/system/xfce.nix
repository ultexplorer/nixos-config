{ pkgs, ... }:

{
  services.xserver = {
    enable = true;
    videoDrivers = [ "amdgpu" ];
    deviceSection = ''Option "TearFree" "true"'';
    desktopManager.xfce.enable = true;
    displayManager.lightdm.enable = false;
  };

  environment.systemPackages = with pkgs; [
    # Видео и аудио софт
    mpv
    ffmpeg-full
    pavucontrol
    xfce.xfce4-pulseaudio-plugin
    
    # Кодеки GStreamer
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-libav

    # Твои приложения
    firefox
    telegram-desktop
    xfce.xfce4-terminal
    xorg.xinit
  ];
}
