{ config, pkgs, ... }:

{
  imports = [
    ./gui/xfce.nix
    ./gui/wayfire.nix
    ./gui/firefox.nix
    ./cli/shell.nix
    ./cli/neovim.nix
    ./tty/console.nix
  ];

  home.username = "me";
  home.homeDirectory = "/home/me";

  programs.home-manager.enable = true;
}
