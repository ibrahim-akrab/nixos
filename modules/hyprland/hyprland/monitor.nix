{
  flake.modules.homeManager.hyprland =
    { pkgs
    , lib
    , ...
    }:
    {
      wayland.windowManager.hyprland.settings = {
        # monitor = [
        #     # Internal panel (primary)
        #     "eDP-1,2880x1800@60.00100,0x0,2"

        #     #External monitors mirrored to eDP-1
        #     "HDMI-A-1,preferred,auto,2,mirror,eDP-1"
        # ];
      };
    };
}
