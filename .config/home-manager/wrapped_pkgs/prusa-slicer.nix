{ pkgs, ... }:
pkgs.symlinkJoin {
  name = "prusa-slicer";
  paths = [ pkgs.prusa-slicer ];
  buildInputs = [ pkgs.makeWrapper ];
  postBuild = ''
    wrapProgram $out/bin/prusa-slicer \
        --set "GTK_THEME" "Adwaita:Dark"
  '';
}
