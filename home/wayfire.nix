{ pkgs, ... }:

{
  home.packages = with pkgs; [
    wayfirePlugins.wcm
    firefox
    waybar
    wofi
    swaybg
    wl-clipboard
    cliphist
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
  
}

