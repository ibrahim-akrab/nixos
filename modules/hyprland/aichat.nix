{
  flake.modules.homeManager.hyprland = { pkgs, ... }:
    {
      home.packages = [ pkgs.aichat ];
      wayland.windowManager.hyprland.extraLuaFiles."80-aichat" = ./lua/80-aichat.lua;
    };
}
