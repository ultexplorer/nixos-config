{ pkgs, ... }:

{
  # Home Manager не "включает" XFCE (это делает система), 
  # но здесь мы можем добавить пакеты, специфичные для XFCE
  home.packages = with pkgs; [
    xfce.xfce4-whiskermenu-plugin # Улучшенное меню
    xfce.xfce4-pulseaudio-plugin  # Управление звуком на панели
  ];
}
