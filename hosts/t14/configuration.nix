{ config, pkgs, ... }:

{
  imports = [
    ../../system/configuration.nix
    ../../system/hardware-configuration.nix
  ];

  networking.hostName = "thinkpad";

  system.stateVersion = "25.11";
}
