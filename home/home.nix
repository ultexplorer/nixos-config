{ pkgs, ... }:

{
  home.username = "me";
  home.homeDirectory = "/home/me";
  home.stateVersion = "24.11";

  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "JetBrainsMono:size=11";
        pad = "15x15";
      };
    };
  };

  home.packages = with pkgs; [
    htop
    git
  ];

  home.sessionVariables = {
    EDITOR = "nano";
    # Для Wayfire может пригодиться:
    # WLR_NO_HARDWARE_CURSORS = "1";
  };

  programs.home-manager.enable = true;

  home.file.".xinitrc".text = ''
      exec xfce4-session
     '';
  home.shellAliases = {
   bright = ''
     sudo bash -c "echo 64764 > /sys/class/backlight/amdgpu_bl1/brightness"
   '';
};
}

