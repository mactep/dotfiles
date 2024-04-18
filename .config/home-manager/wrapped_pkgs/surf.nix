{ pkgs, ... }:
pkgs.symlinkJoin {
  name = "surf";
  paths = [ pkgs.surf ];
  buildInputs = [ pkgs.makeWrapper ];
  postBuild = ''
    wrapProgram $out/bin/surf --set WEBKIT_DISABLE_DMABUF_RENDERER 1
  '';
}
