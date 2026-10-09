{
  flake.modules.homeManager.hyprland =
    { config
    , lib
    , ...
    }:
    let
      hexToRgba = hex: alpha: "rgba(${hex}${alpha})";
    in
    {
      wayland.windowManager.hyprland.extraLuaFiles = {
        "30-looknfeel" = ./lua/30-looknfeel.lua;

        # consumed by lua/30-looknfeel.lua as require("nix.theme")
        "nix.theme" = {
          autoLoad = false;
          content = "return ${lib.generators.toLua { } {
            activeBorder = hexToRgba config.colorScheme.palette.base0D "aa";
            inactiveBorder = hexToRgba config.colorScheme.palette.base09 "aa";
          }}\n";
        };
      };
    };
}
