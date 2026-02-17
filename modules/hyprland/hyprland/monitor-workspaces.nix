{
  flake.modules.homeManager.hyprland =
    { pkgs
    , lib
    , ...
    }:
    {
      wayland.windowManager.hyprland.settings = {
        monitor = [
          # # Internal panel (primary)
          # "eDP-1,2880x1800@60.00100,0x0,2"

          # #External monitors mirrored to eDP-1
          # "HDMI-A-1,preferred,auto,2,mirror,eDP-1"

          # # Built-in laptop displays (covers eDP-1, eDP-2, etc.)
          # "eDP-1,preferred,auto,auto"
          # "eDP-2,preferred,auto,auto"

          # # External monitors extend to the left
          # "HDMI-A-1,preferred,auto-left,auto"
          # "HDMI-A-2,preferred,auto-left,auto"
          # "DP-1,preferred,auto-left,auto"
          # "DP-2,preferred,auto-left,auto"
          # "DP-3,preferred,auto-left,auto"

          # Fallback for any other monitors
          ",preferred,auto-left,auto"
        ];

        # # Workspace assignments
        workspace = [
          # Workspaces 1-5 for built-in displays
          "1,monitor:eDP-1"
          "2,monitor:eDP-1"
          "3,monitor:eDP-1"
          "4,monitor:eDP-1"
          "5,monitor:eDP-1"

          # Workspaces 6-10 for external monitors
          # These will bind to whichever external monitor is connected
          "6,monitor:HDMI-A-1"
          "7,monitor:HDMI-A-1"
          "8,monitor:HDMI-A-1"
          "9,monitor:HDMI-A-1"
          "10,monitor:HDMI-A-1"
        ];
      };
    };
}
