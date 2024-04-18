{ config, lib, pkgs, pkgs-unstable, ... }:
{
  home.packages = [
    pkgs.freecad
    pkgs.prusa-slicer
    # (import ./wrapped_pkgs/prusa-slicer.nix { inherit pkgs; })
    (import ./wrapped_pkgs/orca-slicer.nix { inherit pkgs pkgs-unstable; })
    # pkgs-unstable.orca-slicer
    # mainsail
    # tinkercad
  ];

  # xdg.desktopEntries.mainsail = {
  #   name = "Mainsail";
  #   genericName = "3D Printer Web Interface";
  #   exec = "mainsail";
  #   icon = pkgs.fetchurl {
  #     url = "https://raw.githubusercontent.com/mainsail-crew/docs/master/assets/img/logo.png";
  #     sha256 = "sha256-OLsyednumPZeSxMNLHw7k1QVC5hKngnYt2OtRZRmS04=";
  #   };
  # };
  #
  # xdg.desktopEntries.tinkercad = {
  #   name = "Tinkercad";
  #   genericName = "3D Design";
  #   exec = "tinkercad";
  #   icon = pkgs.fetchurl {
  #     url = "https://www.tinkercad.com/favicon.ico";
  #     sha256 = "sha256-i1RqzmJAv587cY+E9yH/SK9D8DG03rpFA5e0QjQ0d5s=";
  #   };
  # };
}

