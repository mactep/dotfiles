{ config, pkgs, ... }:
{
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome = {
    enable = true;
  };
  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];
  environment.gnome.excludePackages = (with pkgs; [
    gnome-text-editor
    gnome-console
    gnome-photos
    gnome-tour
    gnome-connections
    gedit # text editor
    loupe # image viewer
  ]) ++ (with pkgs.gnome; [
    gnome-characters
    gnome-contacts
    gnome-initial-setup
    gnome-maps
    gnome-music
    gnome-terminal
    gnome-weather
    atomix # puzzle game
    epiphany # web browser
    evince # document viewer
    geary # email reader
    hitori # sudoku game
    iagno # go game
    tali # poker game
    totem # video player
    yelp # Help view
  ]);

  environment.systemPackages = with pkgs; [
    gnomeExtensions.appindicator
  ];
}
