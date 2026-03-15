{ pkgs, ... }: # <-- Эта строка ОБЯЗАТЕЛЬНА

{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "monospace:size=16";
        initial-window-size-chars = "120x30";
        pad-to-center = "yes";
      };
      # CSD (Client Side Decorations) добавляет кнопки окна и рамку
      csd = {
        preferred = "server";
        size = 20;
      };
      pad = {
        padding-left = 20;
        padding-right = 20;
        padding-top = 10;
        padding-bottom = 10;
      };
    };
  };
}
