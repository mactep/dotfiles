{ pkgs, lib, ... }:
{
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    defaultEditor = true;
    withNodeJs = true;
    extraPackages = with pkgs; [
      # for treesitter c compiler
      gcc
      stdenv
      gnumake

      # extra tools
      ripgrep
      lazygit
      golangci-lint
      silicon
      wl-clipboard
      xclip

      # for markdown-preview.nvim
      yarn
      # (import ./wrapped_pkgs/surf.nix { inherit pkgs; })
      # TODO: replace it with tauri/pake

      # language servers
      lua-language-server
      gopls
      buf-language-server
      efm-langserver
      nodePackages.typescript-language-server

      # efm tools
      revive
      prettierd
      jq
      buf
      shellharden
      nixpkgs-fmt
    ];
  };
}

