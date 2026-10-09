{
  flake.modules = {
    nixos.hyprland =
      { pkgs
      , ...
      }:
      {
        programs.hyprland = {
          enable = true;
          package = pkgs.hyprland;
          # make sure to also set the portal package, so that they are in sync
          portalPackage = pkgs.xdg-desktop-portal-hyprland;
        };
      };
    homeManager.hyprland =
      { pkgs
      , ...
      }:
      {
        wayland.windowManager.hyprland = {
          enable = true;
          configType = "lua";
          package = pkgs.hyprland;
          portalPackage = pkgs.xdg-desktop-portal-hyprland;
        };
        services.hyprpolkitagent.enable = true;
      };
  };
}
