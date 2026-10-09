{
  flake.modules.homeManager.hyprland =
    { pkgs
    , lib
    , ...
    }:
    let
      show-bindings = pkgs.writeShellScriptBin "show-bindings" (
        builtins.readFile ./hypr-show-bindings.sh
      );
    in
    {
      services.swayosd = {
        enable = true;
      };

      home.packages = with pkgs; [
        hyprshot
        hyprpicker
        clipse
      ];

      wayland.windowManager.hyprland.extraLuaFiles = {
        "60-bindings" = ./lua/60-bindings.lua;

        # consumed by lua/60-bindings.lua as require("nix.scripts")
        "nix.scripts" = {
          autoLoad = false;
          content = "return ${lib.generators.toLua { } {
            showBindings = lib.getExe show-bindings;
          }}\n";
        };
      };
    };
}
