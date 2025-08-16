{
  flake-file.inputs.hyprland.url = "github:hyprwm/Hyprland";

  flake.modules = {
    nixos.hyprland =
      {
        inputs,
        pkgs,
        ...
      }:
      {
        programs.hyprland = {
          enable = true;
          # set the flake package
          package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
          # make sure to also set the portal package, so that they are in sync
          portalPackage =
            inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
        };
        nix.settings = {
          substituters = [ "https://hyprland.cachix.org" ];
          trusted-substituters = [ "https://hyprland.cachix.org" ];
          trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
        };
      };
    homeManager.hyprland =
      {
        inputs,
        pkgs,
        ...
      }:
      {
        wayland.windowManager.hyprland = {
          enable = true;
          # package = inputs.hyprland.packages.${pkgs.system}.hyprland;
          # set the flake package
          package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
          portalPackage =
            inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
        };
        services.hyprpolkitagent.enable = true;
      };
  };
}
