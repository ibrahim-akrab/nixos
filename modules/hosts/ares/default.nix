{ config, ... }:
let
  my_modules = [
    # Modules
    "audio"
    "base"
    "bluetooth"
    "desktop"
    "dev"
    "hyprland"
    "mixrank"

    # Users
    "ibrahim"
    "root"

    # Host
    "ares"
  ];
  nixosModulesNames = builtins.filter (name: config.flake.modules.nixos ? "${name}") my_modules;
  homeManagerModulesNames = builtins.filter
    (
      name: config.flake.modules.homeManager ? "${name}"
    )
    my_modules;
  nixosModules = map (name: config.flake.modules.nixos."${name}") nixosModulesNames;
  homeManagerModules = map (name: config.flake.modules.homeManager."${name}") homeManagerModulesNames;

  flake.modules.nixos."hosts/ares".imports = nixosModules ++ [
    {
      home-manager.users.ibrahim.imports = homeManagerModules;
    }
  ];
in
{
  inherit flake;
}
