{ config, pkgs, ... }:

{
  imports = [
    ./ags.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    configPackages = [ pkgs.xdg-desktop-portal-gtk ];
  };

  home.packages = with pkgs; [
    # screenshot
    grim
    slurp
    grimblast

    wl-clipboard # clipboard manager
    hyprpaper # wallpaper
    nwg-displays # display manager
    pavucontrol # audio control
    xdg-utils # for opening default programs when clicking links
    gnome.nautilus # file manager
    mate.mate-polkit # polkit agent
    nsxiv # image viewer

    # disabled while using ags
    # pasystray # tray icon for pulseaudio
    # playerctl # media control
    # rofi-wayland # app launcher
    # waybar # status bar
    # eww-wayland # widgets
    # wlogout # logout menu
  ];

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  home.pointerCursor = {
    gtk.enable = true;
    name = "Adwaita";
    package = pkgs.gnome3.adwaita-icon-theme;
    size = 28;
  };
  gtk = {
    enable = true;
    theme = {
      name = "Catppuccin-Mocha-Standard-Green-Dark";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "green" ];
        variant = "mocha";
      };
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders.override {
        accent = "teal";
        flavor = "mocha";
      };
    };
    font = {
      name = "JetBrainsMono Nerd Font";
      package = (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; });
    };
  };

  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };

  # disabled while using ags
  # # notifications
  # services.mako = {
  #   enable = false; # disabled while using ags
  #   anchor = "top-center";
  #   font = "JetBrainsMono Nerd Font 10";
  #   defaultTimeout = 5000;
  #   borderRadius = 3;
  #   borderSize = 2;
  #   extraConfig = ''
  #     background-color=#1e1e2e
  #     text-color=#cdd6f4
  #     border-color=#a6e3a1
  #     progress-color=over #313244

  #     [urgency=high]
  #     border-color=#fab387
  #   '';
  # };

}
