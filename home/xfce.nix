{ pkgs, ... }:

{
  home.packages = with pkgs; [
    chromium
    papirus-icon-theme
    matcha-gtk-theme
    xfce.xfce4-whiskermenu-plugin
    xfce.xfce4-pulseaudio-plugin
    xfce.xfce4-terminal
  ];
  
  gtk = {
    enable = true;

    font.name = "Inter 11";

    theme = {
      name = "Matcha-dark-sea";
      package = pkgs.matcha-gtk-theme;
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };

}
