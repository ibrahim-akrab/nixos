{
  flake.modules.homeManager.hyprland =
    { ...
    }:
    {
      wayland.windowManager.hyprland.extraLuaFiles."10-envs" = ./lua/10-envs.lua;
    };
}
