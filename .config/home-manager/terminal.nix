{ pkgs, ... }:

let
  catppuccin-fish = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "fish";
    rev = "0ce27b518e8ead555dec34dd8be3df5bd75cff8e";
    hash = "sha256-Dc/zdxfzAUM5NX8PxzfljRbYvO9f9syuLO8yBr+R3qg=";
  };
in
{
  home.packages = with pkgs; [
    alacritty
    yazi # terminal file browser
    ueberzugpp # image preview for yazi
    jq # json processor
    ripgrep # "better" grep
    bat # "better" cat
    lazygit
    (nerdfonts.override { fonts = [ "JetBrainsMono" "Monaspace" ]; })

  ];

  programs.fish = {
    enable = true;
    functions = {
      fish_prompt = ''
        set_color green
        printf '➜ '
        set_color blue
        printf '%s ' (basename (prompt_pwd))
        set_color normal
        printf '%s$ ' (string sub -s 3 -e -1 (fish_git_prompt))
      '';
    };
    interactiveShellInit = ''
      set -g fish_greeting
      fish_config theme choose "Catppuccin Mocha"
      bind \cO accept-autosuggestion
    '';
    shellAliases = {
      cat = "bat --paging=never --style=plain";
    };
  };
  xdg.configFile."fish/themes/Catppuccin Mocha.theme".source = "${catppuccin-fish}/themes/Catppuccin Mocha.theme";

  programs.tmux = {
    enable = true;
    baseIndex = 1;
    clock24 = true;
    escapeTime = 0;
    keyMode = "vi";
    prefix = "C-a";
    plugins = [
      {
        plugin = pkgs.tmuxPlugins.yank;
        extraConfig = ''
          # bind-key -T copy-mode-vi v send-keys -X begin-selection
          bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
        '';
      }
    ];
    extraConfig = ''
      set-option -g renumber-windows on

      set -g default-terminal "tmux-256color"
      set -ga terminal-overrides ",*256col*:Tc"

      set -g status-bg black
      set -g status-fg white

      # Shift Alt vim keys to switch windows
      bind -n M-H previous-window
      bind -n M-L next-window

      # Open panes in current directory
      bind '"' split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
    '';
  };

  programs.bat = {
    enable = true;
    config = {
      theme = "catppuccin";
    };
    themes = {
      catppuccin = {
        src = pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "bat";
          rev = "ba4d16880d63e656acced2b7d4e034e4a93f74b1";
          sha256 = "6WVKQErGdaqb++oaXnY3i6/GuH2FhTgK0v4TN4Y0Wbw=";
        };
        file = "Catppuccin-mocha.tmTheme";
      };
    };
  };
}
