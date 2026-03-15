{ config, pkgs, ... }:

{
  imports = [
    ./gui/xfce.nix
    ./gui/wayfire.nix
    ./gui/firefox.nix
    ./gui/foot.nix
    ./cli/shell.nix
#    ./cli/neovim.nix
 #   ./tty/console.nix
  ];

  home.username = "me";
  home.homeDirectory = "/home/me";

  # --- НОВОЕ ---
  # VS Code с плагинами
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
      mkhl.direnv
    ];
  };
  # Foot -----------------------------------#
  programs.foot = {
    enable = true;

  };
  ###########################################

  # Автозапуск EasyEffects в фоне
  services.easyeffects.enable = true;

  # Сервер для работы Nix в редакторе
  home.packages = with pkgs; [
    nil 
  ];
  # -------------

  programs.home-manager.enable = true;
  home.stateVersion = "23.11"; # Обязательно добавь эту строку, если её нет
}
