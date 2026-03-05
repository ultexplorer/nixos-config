{ pkgs, ... }:

{
  home.stateVersion = "25.11";

  imports = [
    ./xfce.nix
    ./wayfire.nix
  ];

  fonts.fontconfig.enable = true;

  home.sessionVariables = {
  LIBVA_DRIVER_NAME = "radeonsi";
  MOZ_DISABLE_RDD_SANDBOX = "1";
};

  home.packages = with pkgs; [
    pavucontrol
    inter
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    freetube
    mpv
    yt-dlp
  ];
  ###########################

}
