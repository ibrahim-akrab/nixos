{
  flake.modules.homeManager.hyprland =
    { config
    , pkgs
    , lib
    , ...
    }:
    {
      home.packages = with pkgs; [
        hyprsunset
      ];

      wayland.windowManager.hyprland.extraLuaFiles = {
        "70-autostart" = ./lua/70-autostart.lua;

        # consumed by lua/70-autostart.lua as require("nix.cursor")
        "nix.cursor" = {
          autoLoad = false;
          content = "return ${lib.generators.toLua { } {
            name = config.gtk.cursorTheme.name;
            size = config.gtk.cursorTheme.size;
          }}\n";
        };
      };
    };
}
