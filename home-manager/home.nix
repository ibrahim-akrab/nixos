{
  config,
  pkgs,
  ...
}: {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "ibrahim";
  home.homeDirectory = "/home/ibrahim";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    slack
    telegram-desktop

    firefox
    tree
    cht-sh
    lazygit
    vim
    wget
    git
    (nerdfonts.override {fonts = ["FiraCode" "DroidSansMono"];})

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      dracula-theme.theme-dracula
      vscodevim.vim
      yzhang.markdown-all-in-one
      ms-python.python
      ms-pyright.pyright
      kamadorueda.alejandra
      bbenoist.nix
    ];
  };

  # Shell
  programs.bash.enable = true;

  # Prompt
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    settings = {
      add_newline = false;
      line_break = {
        disabled = true;
      };
    };
  };

  # Commandline Tools
  programs.htop.enable = true;
  programs.bat.enable = true;
  programs.lsd.enable = true;
  programs.kitty = {
    enable = true;
    font.name = "FiraCode";
    shellIntegration.enableBashIntegration = true;
    themeFile = "Catppuccin-Mocha";
  };
  programs.tmux = {
    enable = true;
    aggressiveResize = true;
    keyMode = "vi";
    mouse = true;
    prefix = "C-a";
    extraConfig = ''
            bind C-a last-window
      set -g base-index 0
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
      {
        plugin = resurrect;
        extraConfig = ''
          set -g @resurrect-strategy-vim 'session'
          set -g @resurrect-strategy-nvim 'session'
          set -g @resurrect-capture-pane-contents 'on'
        '';
      }
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-boot 'on'
          set -g @continuum-save-interval '10'
        '';
      }
    ];
  };

services.kdeconnect.enable = true;

  fonts.fontconfig.enable = true;

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/ibrahim/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "vim";
  };

  home.shellAliases = {
    ".." = "cd ..";
    "..." = "cd ../..";
    "ls" = "lsd";
    "l" = "lsd";
    "ll" = "lsd -l";
    "la" = "lsd -la";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
