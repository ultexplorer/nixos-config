{ pkgs, ... }:

{
  services.xserver = {
    enable = true;
    desktopManager.xfce.enable = true;
    # Это заставит систему "увидеть" сессию, даже если она капризничает
    displayManager.sessionPackages = [ pkgs.xfce.xfce4-session ];
  };

  # Добавляем сам пакет сессии в систему принудительно
  environment.systemPackages = with pkgs; [
    xfce.xfce4-session
    xfce.xfce4-settings
    xfce.xfce4-panel
    xfce.xfconf
  ];

  # Даем знать greetd, что X11 сессии лежат тут
  services.displayManager.sessionData.dirs = [ "${pkgs.xfce.xfce4-session}/share/xsessions" ];
}
