{ pkgs, ... }:

{
  # Локализация
  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "Europe/Berlin"; # Настрой под себя

  # Настройка консоли (TTY)
  console = {
    font = "ter-v32n"; 
    packages = [ pkgs.terminus_font ];
    keyMap = "us";
  };

  # Шрифты для системы (GUI)
  fonts.packages = with pkgs; [
    terminus_font
  ];

  # Общие пакеты, которые нужны везде (даже на сервере)
  environment.systemPackages = with pkgs; [
    vim
    mc
    git
    wget
    curl
    htop
    pciutils # Чтобы смотреть железо через lspci
    usbutils # Чтобы видеть твою будущую клавиатуру через lsusb
  ];
}
