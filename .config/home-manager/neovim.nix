{ pkgs, ... }:
{
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
    }))
  ];
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    defaultEditor = true;
    withNodeJs = true;
    extraPackages = [
      # for treesitter c compiler
      pkgs.gcc
      pkgs.stdenv
      pkgs.gnumake

      # extra tools
      pkgs.ripgrep
      pkgs.lazygit
      pkgs.golangci-lint
      pkgs.silicon
      pkgs.wl-clipboard
      pkgs.xclip

      # language servers
      pkgs.lua-language-server
      pkgs.gopls
      pkgs.buf-language-server
      pkgs.efm-langserver
      pkgs.nodePackages.typescript-language-server

      # efm tools
      pkgs.revive
      pkgs.prettierd
      pkgs.jq
      pkgs.buf
      pkgs.shellharden
      pkgs.nixpkgs-fmt
    ];
  };
}

