{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        gnome3.adwaita-icon-theme  # default gnome cursors
        grim
        slurp
        grimblast
        hyprpaper
        mako
        nwg-displays
        papirus-icon-theme
        pasystray
        pavucontrol
        playerctl
        rofi-wayland
        waybar
        wl-clipboard
        xdg-utils # for opening default programs when clicking links
        gnome.nautilus
        mate.mate-polkit
        nsxiv
        eww-wayland
        wlogout
    ];

    fonts.packages = with pkgs; [
        (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];

    programs.hyprland = {
        enable = true;
        xwayland.enable = true;
    };

    # Optional, hint electron apps to use wayland:
    environment.sessionVariables.NIXOS_OZONE_WL = "1";

    # xdg portal for hyprland, not sure if it's needed elsewhere
    xdg.portal.enable = true;
    xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    xdg.portal.configPackages = [ pkgs.xdg-desktop-portal-gtk ];

    # authentication agent
    security.polkit.enable = true;

    programs.fish.loginShellInit = ''
        bash -c '
            if [ "$(tty)" = "/dev/tty1" ]; then
                exec Hyprland
            fi
        '
    '';

    services.blueman.enable = true;
}
