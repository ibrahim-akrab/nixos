{
  flake.modules.homeManager.hyprland = { ... }: {
    wayland.windowManager.hyprland.extraLuaFiles."50-windows" = ./lua/50-windows.lua;
  };
}
