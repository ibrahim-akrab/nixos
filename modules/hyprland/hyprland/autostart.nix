{
  flake.modules.homeManager.hyprland =
    {
      config,
      pkgs,
      ...
    }:
    {
      home.packages = with pkgs; [
        hyprsunset
        wl-clip-persist
        clipse
        wl-clipboard
      ];
      wayland.windowManager.hyprland.settings = {
        exec-once = [
          # "hypridle & mako & waybar & fcitx5"
          # "waybar"
          # "swaybg -i ~/.config/omarchy/current/background -m fill"
          "hyprsunset"
          "systemctl --user start hyprpolkitage"
          "wl-clip-persist --clipboard regular & clipse -listen"
          "hyprctl setcursor ${config.gtk.cursorTheme.name} ${toString config.gtk.cursorTheme.size}"

          # "dropbox-cli start"  # Uncomment to run Dropbox
        ];

        exec = [
          "pkill -SIGUSR2 waybar || waybar"
        ];
      };
    };
}
