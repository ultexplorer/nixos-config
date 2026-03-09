{ config, pkgs, ... }:

{
  programs.xfce4.enable = true;

  home.packages = with pkgs; [
    thunar
    mousepad
    xfce4-terminal
  ];
}
