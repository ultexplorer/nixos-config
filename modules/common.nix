{ pkgs, myUser, ... }:

{
  # Настройки Nix и Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Загрузчик (Systemd-boot)
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Сеть
  networking.networkmanager.enable = true;

  # Локализация и время
  time.timeZone = "Europe/Berlin"; 
  i18n.defaultLocale = "en_US.UTF-8";

  # Определение пользователя через глобальную переменную
  users.users.${myUser} = {
    isNormalUser = true;
    description = "Master of T14";
    extraGroups = [ "wheel" "networkmanager" "video" "audio" "render" "input" ];
  };

  # Разрешаем несвободное ПО
  nixpkgs.config.allowUnfree = true;

  # Базовый набор софта
  environment.systemPackages = with pkgs; [
    git vim wget curl tree pciutils usbutils inxi htop btop
  ];

  # Шрифт для консоли
  console = {
    earlySetup = true;
    font = "ter-v32n";
    packages = with pkgs; [ terminus_font ];
  };
}

