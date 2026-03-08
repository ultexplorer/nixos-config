{ pkgs, ... }:

{
  home.stateVersion = "25.11";

  imports = [
    ./xfce.nix
    ./wayfire.nix
    ../modules/home/apps/cli.nix
    ../modules/home/apps/gui.nix
    ../modules/home/apps/dev.nix
    ../modules/home/apps/fonts.nix
  ];

  fonts.fontconfig.enable = true;

  home.sessionVariables = {
  LIBVA_DRIVER_NAME = "radeonsi";
  MOZ_DISABLE_RDD_SANDBOX = "1";
};
 
 home.file.".config/xfce4/xfconf/xfce-perchannel-xml/xfwm4.xml" = {
    text = ''
<?xml version="1.0" encoding="UTF-8"?>
<channel name="xfwm4" version="1.0">
  <property name="general" type="empty">
    <property name="vblank_mode" type="string" value="auto"/>
  </property>
</channel>
'';
    force = true;
  };
}
