{ config, ... }:
let
  my_modules = [
    # Modules
    "audio"
    "base"
    "battery"
    "bluetooth"
    "desktop"
    "dev"
    "hyprland"
    "impermanence"
    "intel"
    "laptop"
    "mixrank"
    "secure-boot"

    # Users
    "ibrahim"
    "root"

    # Host
    "apollo"
  ];
  nixosModulesNames = builtins.filter (name: config.flake.modules.nixos ? "${name}") my_modules;
  homeManagerModulesNames = builtins.filter
    (
      name: config.flake.modules.homeManager ? "${name}"
    )
    my_modules;
  nixosModules = map (name: config.flake.modules.nixos."${name}") nixosModulesNames;
  homeManagerModules = map (name: config.flake.modules.homeManager."${name}") homeManagerModulesNames;

  flake.modules.nixos."hosts/apollo".imports = nixosModules ++ [
    {
      home-manager.users.ibrahim.imports = homeManagerModules;
    }
  ];
in
{
  inherit flake;
}
