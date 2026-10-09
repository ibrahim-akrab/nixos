{
  flake.modules.homeManager.hyprland =
    { ...
    }:
    {
      wayland.windowManager.hyprland.extraLuaFiles."20-input" = ./lua/20-input.lua;
    };
}
