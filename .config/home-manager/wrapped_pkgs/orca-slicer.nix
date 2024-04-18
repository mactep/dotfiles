{ pkgs, pkgs-unstable, ... }:
pkgs.symlinkJoin {
  name = "orca-slicer";
  paths = [ pkgs-unstable.orca-slicer ];
  buildInputs = [ pkgs.makeWrapper ];
  postBuild = ''
    wrapProgram $out/bin/orca-slicer \
        --set WEBKIT_DISABLE_DMABUF_RENDERER 1 \
        --set GTK_THEME Adwaita:Light
  '';
}
