{ pkgs, ... }:

{
  home.packages = with pkgs; [
    firefox
    thunderbird
    freetube
    mpv
    pavucontrol
  ];
  
  home.file.".config/xfce4/xfconf/xfce-perchannel-xml/xfwm4.xml".text = ''
   <?xml version="1.0" encoding="UTF-8"?>
   <channel name="xfwm4" version="1.0">
   <property name="general" type="empty">
     <property name="vblank_mode" type="string" value="auto"/>
   </property>
  </channel>
  '';

}
