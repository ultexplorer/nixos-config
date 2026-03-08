{ pkgs, ... }:

{
  home.stateVersion = "25.11";

  imports = [
    ./xfce.nix
    ./wayfire.nix
    ../modules/home/apps/cli.nix
    ../modules/home/apps/gui.nix
    ../modules/home/apps/dev.nix
    ../modules/home/fonts.nix
  ];

  fonts.fontconfig.enable = true;

  home.sessionVariables = {
  LIBVA_DRIVER_NAME = "radeonsi";
  MOZ_DISABLE_RDD_SANDBOX = "1";
};

}
