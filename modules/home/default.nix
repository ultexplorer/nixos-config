{ pkgs, myUser, ... }: # Принимаем переменную из flake.nix

{
  # Автоматически подставляем имя и путь
  home.username = myUser;
  home.homeDirectory = "/home/${myUser}";
  
  home.stateVersion = "24.11";

  # Включаем сам Home Manager
  programs.home-manager.enable = true;

  # Твои настройки оболочки
  programs.bash = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
      # Наш кастомный алиас для сборки (теперь универсальный)
      ray = "sudo nixos-rebuild switch --flake .#t14";
    };
  };

  # Здесь будут пакеты, которые ставятся ТОЛЬКО для этого пользователя
  home.packages = with pkgs; [
    # Например:
    # telegram-desktop
  ];
}
