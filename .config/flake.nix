{
  description = "Home Manager and NixOS configuration of mactep";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";

    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";

    ags.url = "github:Aylur/ags";

    firefox-gnome-theme = {
      url = "github:rafaelmardojai/firefox-gnome-theme";
      flake = false;
    };

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = { nixpkgs, nixpkgs-unstable, home-manager, ... }@inputs:
    let
      # system settings
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [ inputs.neovim-nightly-overlay.overlay ];
      };

      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
      };

      # user settings
      user = {
        name = "mactep";
        email = "brunoro.tulio@gmail.com";
        shell = "fish";
      };
    in
    {
      nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs system user; };
        modules = [ ./nixos/configuration.nix ];
      };

      homeConfigurations.${user.name} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit inputs user pkgs-unstable; };
        modules = [ ./home-manager/home.nix ];
      };
    };
}
