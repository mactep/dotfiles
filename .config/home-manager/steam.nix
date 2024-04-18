{ pkgs, lib, ... }:

{

  home.packages = with pkgs; [
    steam
    steam-run
  ];

  xdg.desktopEntries.steam = {
    name = "Steam";
    exec = "steam";
    icon = "steam";
    type = "Application";
    categories = [ "Game" ];
  };
}
