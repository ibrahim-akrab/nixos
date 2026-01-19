{
  flake.modules.homeManager.hyprland = {...}: {
    wayland.windowManager.hyprland.settings = {
      windowrule = [
        # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
        "suppress_event maximize, match:class .*"

        # Force chromium into a tile to deal with --app bug
        "tile on, match:class ^(chromium)$"

        # Settings management
        "float on, match:class ^(org.pulseaudio.pavucontrol|.blueman-manager-wrapped)$"

        # Float Steam, fullscreen RetroArch
        "float on, match:class ^(steam)$"
        "fullscreen on, match:class ^(com.libretro.RetroArch)$"

        # Just dash of transparency
        "opacity 0.97 0.9, match:class .*"
        # Normal chrome Youtube tabs
        "opacity 1 1, match:class ^(chromium|google-chrome|google-chrome-unstable)$, match:title .*Youtube.*"
        "opacity 1 0.97, match:class ^(chromium|google-chrome|google-chrome-unstable)"
        "opacity 0.97 0.9, match:initial_class ^(chrome-.*-Default)$ # web apps"
        "opacity 1 1, match:initial_class ^(chrome-youtube.*-Default)$ # Youtube"
        "opacity 1 1, match:class ^(zoom|vlc|org.kde.kdenlive|com.obsproject.Studio)$"
        "opacity 1 1, match:class ^(com.libretro.RetroArch|steam)$"

        # Fix some dragging issues with XWayland
        "no_focus on, match:class ^$, match:title ^$, match:xwayland 1, match:float 1, match:fullscreen 0, match:pin 0"

        # Float in the middle for clipse clipboard manager
        "float on, match:class (clipse)"
        "size 622 652, match:class (clipse)"
        "stay_focused on, match:class (clipse)"
      ];

      layerrule = [
        # Proper background blur for wofi
        "blur on, match:namespace wofi"
        "blur on, match:namespace waybar"
      ];
    };
  };
}
