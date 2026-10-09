{
  flake.modules.homeManager.hyprland =
    { pkgs
    , lib
    , ...
    }:
    let
      browser = "${lib.getExe pkgs.librewolf} --new-window";
    in
    {
      # Default applications, consumed by lua/60-bindings.lua as require("nix.apps")
      wayland.windowManager.hyprland.extraLuaFiles."nix.apps" = {
        autoLoad = false;
        content = "return ${lib.generators.toLua { } {
          inherit browser;
          terminal = lib.getExe pkgs.kitty;
          fileManager = lib.getExe' pkgs.kdePackages.dolphin "dolphin";
          # music = "spotify";
          passwordManager = lib.getExe pkgs.bitwarden-desktop;
          messenger = lib.getExe pkgs.telegram-desktop;
          webapp = "${browser} --app";
        }}\n";
      };
    };
}
