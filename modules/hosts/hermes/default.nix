{ config, inputs, ... }:
let
  my_modules = [
    # Shared modules
    "audio"
    "base"
    "bluetooth"
    "determinate-nix"
    "dev"
    "ibrahim"
    "root"
    # Host
    "alioth"
    "hermes"
  ];
  nixosModulesNames = builtins.filter (name: config.flake.modules.nixos ? "${name}") my_modules;
  homeManagerModulesNames = builtins.filter
    (name: config.flake.modules.homeManager ? "${name}")
    my_modules;
  nixosModules = map (name: config.flake.modules.nixos."${name}") nixosModulesNames;
  homeManagerModules = map (name: config.flake.modules.homeManager."${name}") homeManagerModulesNames;
in
{
  flake.modules.nixos."hosts/hermes".imports = nixosModules ++ [
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager.users.ibrahim.imports = homeManagerModules;
    }
  ];
}
