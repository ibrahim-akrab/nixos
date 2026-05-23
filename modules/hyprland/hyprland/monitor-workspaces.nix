{
  flake.modules.homeManager.hyprland =
    {
      wayland.windowManager.hyprland.settings = {
        monitor = [
          ",preferred,auto-up,auto"
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
