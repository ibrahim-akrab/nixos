{
  flake.modules.homeManager.hyprland =
    {
      pkgs,
      ...
    }:
    {
      home.packages = with pkgs; [
        hyprsunset
        wl-clip-persist
        clipse
      ];
      wayland.windowManager.hyprland.settings = {
        exec-once = [
          # "hypridle & mako & waybar & fcitx5"
          # "waybar"
          # "swaybg -i ~/.config/omarchy/current/background -m fill"
          "hyprsunset"
          "systemctl --user start hyprpolkitage"
          "wl-clip-persist --clipboard regular & clipse -listen"

          # "dropbox-cli start"  # Uncomment to run Dropbox
        ];

        exec = [
          "pkill -SIGUSR2 waybar || waybar"
        ];
      };
    };
}
