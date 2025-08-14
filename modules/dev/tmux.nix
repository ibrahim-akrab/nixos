{
  flake.modules.homeManager.dev =
    { pkgs, ... }:
    {
      programs.tmux = {
        enable = true;
        aggressiveResize = true;
        keyMode = "vi";
        mouse = true;
        prefix = "C-a";
        extraConfig = ''
          bind C-a last-window
          set -g base-index 1
          setw -g pane-base-index 1
          set -g renumber-windows on
        '';
        plugins = with pkgs.tmuxPlugins; [
          pain-control
          {
            plugin = tmux-thumbs;
            extraConfig = ''
              set -g @thumbs-key f
            '';
          }
          vim-tmux-navigator
          # must be before continuum edits right status bar
          {
            plugin = catppuccin;
            extraConfig = ''
              set -g @catppuccin_flavour 'mocha'
              set -g @catppuccin_window_tabs_enabled on
              set -g @catppuccin_window_default_text "#W"
              set -g @catppuccin_window_current_text "#W"
              set -g @catppuccin_date_time "%H:%M"
              set -g @catppuccin_status_modules_right "directory session date_time"
            '';
          }
        ];
      };
    };
}
