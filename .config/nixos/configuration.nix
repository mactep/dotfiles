# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, user, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./locale.nix
      ./nvidia.nix
      ./interception-tools.nix
      # ./hyprland.nix
      ./gnome.nix
      ./audio.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    # Enable networking
    networkmanager.enable = true;

    hostName = "nixos"; # Define your hostname.
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.


    # Configure network proxy if necessary
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };

  # nix
  nixpkgs.config.allowUnfree = true;
  nix = {
    settings = {
      experimental-features = "nix-command flakes";
      auto-optimise-store = true;
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${user.name} = {
    isNormalUser = true;
    description = user.name;
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ ];
    shell = pkgs.${user.shell};
  };

  programs.${user.shell} = (
    if pkgs.${user.shell} != "bash" then {
      enable = true;
    } else {}
  );

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    firefox
    wget
    vim
    gparted
  ];

  # supposed to fix some issues with wayland+electron
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

  # docker
  virtualisation = {
    docker = {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
  };


  services = {
    # Enable the OpenSSH daemon.
    openssh.enable = true;

    # this is supposed to fix some issues related to shebangs, /bin/bash etc...
    # it makes the system feel more like a regular linux distro, may be the culprit
    # for future issues
    envfs.enable = true;

    # needed for gnome-disks
    udisks2.enable = true;
  };

  programs = {
    git = {
      enable = true;
      prompt.enable = true;
    };
  };

  # authentication agent
  security.polkit.enable = true;
}
