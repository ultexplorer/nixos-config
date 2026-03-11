{ pkgs, ... }:

{
  # Локализация
  i18n.defaultLocale = "ru_RU.UTF-8";
  time.timeZone = "Europe/Berlin"; # Настрой под себя

  # Настройка консоли (TTY)
  console = {
    font = "ter-v32n"; 
    packages = [ pkgs.terminus_font ];
    keyMap = "ru";
  };

  # Шрифты для системы (GUI)
  fonts.packages = with pkgs; [
    terminus_font
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  # Общие пакеты, которые нужны везде (даже на сервере)
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    htop
    curl
  ];
}
