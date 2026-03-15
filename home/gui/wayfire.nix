{ config, pkgs, ... }:

{
  # Создаем файл конфига прямо в ~/.config/wayfire.ini
  home.file.".config/wayfire.ini".text = ''
    [core]
    plugins = \
      alpha \
      animate \
      autostart \
      command \
      cube \
      expo \
      grid \
      move \
      place \
      resize \
      switcher \
      vswitch \
      wobbly \
      wrot

    [cube]
    activate = <ctrl> <alt> BTN_LEFT
    rotate_left = <ctrl> <alt> KEY_LEFT
    rotate_right = <ctrl> <alt> KEY_RIGHT

    [wobbly]
    friction = 3.000000
    spring_k = 2.000000

    [autostart]
    # Вот здесь мы ГАРАНТИРОВАННО запускаем EasyEffects
    audio = easyeffects --daemon
    # И панель
    panel = wf-panel
    background = wf-background
  '';
}
