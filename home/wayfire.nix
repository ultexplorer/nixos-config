{ pkgs, ... }:

{
  home.packages = with pkgs; [
    foot

    wayfirePlugins.wcm
    firefox
    waybar
    wofi
    swaybg
    wl-clipboard
    cliphist
    
    mako
    grim
  ];

  home.file.".config/waybar/config.jsonc".text = ''
  {
    "layer": "top",
    "position": "top",
    "height": 30,
    "modules-left": ["wlr/workspaces", "clock"],
    "modules-center": [],
    "modules-right": ["pulseaudio", "network", "battery", "tray"],
    "wlr/workspaces": {
      "format": "{icon}",
      "on-click": "activate"
    },
    "clock": {
      "format": " {:%H:%M  %d.%m.%Y}"
    },
    "battery": {
      "format": " {capacity}%",
      "format-charging": " {capacity}%"
    },
    "network": {
      "format-wifi": " {essid}",
      "format-disconnected": "disconnected"
    },
    "pulseaudio": {
      "format": " {volume}%",
      "on-click": "pavucontrol"
    }
  }
'';
  
  home.file.".config/wayfire.ini".text = ''
    [core]
    plugins = autostart command move resize grid place expo vswitch window-rules
    close_top_view = <super> KEY_Q

    [command]
    # Теперь используем Super + T для foot
    binding_terminal = <super> KEY_T
    command_terminal = foot

    [move]
    activate = <super> BTN_LEFT

    [resize]
    activate = <super> BTN_RIGHT
    [autostart]
    bar = waybar
    wallpaper = swaybg -m fill -i /path/to/your/image.jpg
    # Если хочешь, чтобы при старте сразу работал буфер обмена:
    clipboard = wl-paste --watch cliphist store
  '';
}  



