{ config, pkgs, lib, user, ... }:

{
  home.pointerCursor = {
    gtk.enable = true;
    name = "Adwaita";
    package = pkgs.gnome3.adwaita-icon-theme;
    size = 28;
  };
  gtk = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.catppuccin-papirus-folders.override {
        accent = "teal";
        flavor = "mocha";
      };
    };
    gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
  };

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/input-sources" = {
        sources = [ (lib.hm.gvariant.mkTuple [ "xkb" "us+altgr-intl" ]) ];
      };

      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        enable-hot-corners = false;
      };

      "org/gnome/desktop/wm/preferences" = {
        num-workspaces = 4;
        button-layout = "appmenu:minimize,maximize,close";
      };

      "org/gnome/desktop/peripherals/mouse" = {
        accel-profile = "flat";
      };

      "org/gnome/desktop/session" = {
        idle-delay = lib.hm.gvariant.mkUint32 300;
      };

      "org/gnome/desktop/background" = {
        picture-options = "zoom";
        picture-uri = "file:///home/${user.name}/Pictures/wallpaper.png";
        picture-uri-dark = "file:///home/${user.name}/Pictures/wallpaper.png";
      };

      "org/gnome/desktop/sound" = {
        event-sounds = false;
      };

      "org/gnome/desktop/screensaver" = {
        picture-options = "zoom";
        picture-uri = "file:///home/${user.name}/Pictures/wallpaper.png";
      };

      "org/gnome/desktop/wm/keybindings" = {
        move-to-workspace-1 = [ "<Shift><Super>1" ];
        move-to-workspace-2 = [ "<Shift><Super>2" ];
        move-to-workspace-3 = [ "<Shift><Super>3" ];
        move-to-workspace-4 = [ "<Shift><Super>4" ];
        close = [ "<Super>j" ];
        maximize = [ ];
        minimize = [ ];
        show-desktop = [ "<Super>d" ];
        switch-to-workspace-1 = [ "<Super>1" ];
        switch-to-workspace-2 = [ "<Super>2" ];
        switch-to-workspace-3 = [ "<Super>3" ];
        switch-to-workspace-4 = [ "<Super>4" ];
        switch-applications = [ ];
        switch-applications-backwards = [ ];
        switch-windows = [ "<Alt>Tab" ];
        switch-windows-backward = [ "<Shift><Alt>Tab" ];
        toggle-fullscreen = [ "<Super>f" ];
        toggle-maximized = [ "<Super>k" ];
        switch-input-source = [ ];
        switch-input-source-backward = [ ];
      };

      "org/gnome/mutter" = {
        edge-tiling = true;
        workspaces-only-on-primary = true;
      };

      "org/gnome/mutter/keybindings" = {
        toggle-tiled-left = [ "<Super>h" ];
        toggle-tiled-right = [ "<Super>l" ];
      };

      "org/gnome/nautilus/preferences" = {
        default-folder-viewer = "list-view";
        migrated-gtk-settings = true;
        search-filter-time-type = "last_modified";
      };

      "org/gnome/nautilus/window-state" = {
        maximized = false;
      };

      "org/gnome/shell" = {
        enabled-extensions = [
          "appindicatorsupport@rgcjonas.gmail.com"
        ];
      };

      "org/gnome/shell/keybindings" = {
        switch-to-application-1 = [ ];
        switch-to-application-2 = [ ];
        switch-to-application-3 = [ ];
        switch-to-application-4 = [ ];
        switch-to-application-5 = [ ];
      };

      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings = [ "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" ];
        screensaver = [ ];
        volume-mute = [ "AudioMute" ];
        mic-mute = [ "AudioMicMute" ];
        next = [ "AudioNext" ];
        play = [ "AudioPlay" ];
        previous = [ "AudioPrev" ];
        stop = [ "AudioStop" ];
        volume-down = [ "AudioLowerVolume" ];
        volume-up = [ "AudioRaiseVolume" ];

        home = [ "<Super>e" ];
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        binding = "<Super>Return";
        command = "alacritty";
        name = "alacritty";
      };

      "org/gnome/settings-daemon/plugins/power" = {
        sleep-inactive-ac-timeout = lib.hm.gvariant.mkUint32 1800;
      };

      "system/locale" = {
        region = "pt_BR.UTF-8";
      };
    };
  };
}
