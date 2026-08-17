{
  flake.modules.homeManager.hyprland =
    { config
    , pkgs
    , ...
    }:
    {
      home.packages = with pkgs; [
        hyprsunset
      ];
      wayland.windowManager.hyprland.settings = {
        exec-once = [
          # "hypridle & mako & waybar & fcitx5"
          # "waybar"
          # "swaybg -i ~/.config/omarchy/current/background -m fill"
          "hyprsunset"
          "systemctl --user start hyprpolkitage"
          # clipboard daemons live in ../clipboard.nix as systemd user services
          "hyprctl setcursor ${config.gtk.cursorTheme.name} ${toString config.gtk.cursorTheme.size}"

          # "dropbox-cli start"  # Uncomment to run Dropbox
        ];

        exec = [
          "pkill -SIGUSR2 waybar || waybar"
        ];
      };
    };
}
