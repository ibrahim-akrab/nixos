{
  flake.modules.homeManager.hyprland =
    {
      lib,
      ...
    }:
    {
      wayland.windowManager.hyprland.settings = {
        # Environment variables
        # https://wiki.hyprland.org/Configuring/Variables/#input
        input = lib.mkDefault {
          kb_layout = "us";
          # kb_variant =
          # kb_model =
          # kb_options = "compose:caps";
          # kb_rules =

          follow_mouse = 1;

          sensitivity = 0; # -1.0 - 1.0, 0 means no modification.

          touchpad = {
            natural_scroll = true;
            drag_lock = 0;
          };
        };

        # https://wiki.hyprland.org/Configuring/Variables/#gestures
        gestures = lib.mkDefault {
          gesture = [
            "3, horizontal, workspace"
            "3, pinch, scale: 1.5, fullscreen"
          ];
        };
      };
    };
}
