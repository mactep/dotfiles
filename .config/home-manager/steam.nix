{ pkgs, lib, ... }:

{

  home.packages = with pkgs; [
    steam
    steam-run
  ];

  home.sessionVariables = { };

  home.file = {
    ".local/share/applications/steam.desktop".text = ''
      [Desktop Entry]
      Name=Steam
      Exec=steam
      Icon=steam
      Type=Application
      Categories=Game
    '';
  };
}
