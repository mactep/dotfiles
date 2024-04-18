{ config, pkgs, ... }:
{
  services.xserver = {
    enable = true;
    displayManager.defaultSession = "xfce";
    desktopManager = {
      xterm.enable = false;
      xfce.enable = true;
    };
  };
}
