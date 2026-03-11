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

   # 1. Сеть (NetworkManager)
  networking.networkmanager.enable = true;

  # 2. Bluetooth (Железо + Сервис)
  hardware.bluetooth.enable = true; # Включает поддержку в ядре
  services.blueman.enable = true;   # Включает менеджер (тот самый синий значок)

  # 3. Звук (Pipewire — современный стандарт, отлично для Wayland)
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
}
