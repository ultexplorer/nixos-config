{ pkgs, ... }:

{
  home.stateVersion = "25.11";

  gtk = {
    enable = true;
    font.name = "Inter 11";
  };

  fonts.fontconfig.enable = true;

  home.file.".config/xfce4/xfconf/xfce-perchannel-xml/xfwm4.xml".text = ''
<?xml version="1.0" encoding="UTF-8"?>
<channel name="xfwm4" version="1.0">
  <property name="general" type="empty">
    <property name="vblank_mode" type="string" value="auto"/>
  </property>
</channel>
'';

}
