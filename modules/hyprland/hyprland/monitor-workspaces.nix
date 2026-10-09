{
  flake.modules.homeManager.hyprland =
    {
      wayland.windowManager.hyprland.extraLuaFiles."40-monitors" = ./lua/40-monitors.lua;
    };
}
