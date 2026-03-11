{ config, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    # Если у тебя AMD версия T14:
   # inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t14-gen1-amd
  ];

  networking.hostName = "t14";

  # Здесь твои базовые настройки
  time.timeZone = "Europe/Moscow"; # Или твой пояс
  i18n.defaultLocale = "en_US.UTF-8";

  # Не забудь про юзера, чтобы не остаться снаружи!
  users.users.me = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  system.stateVersion = "23.11"; 
}
