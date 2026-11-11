{ inputs, ... }:
{
  flake-file.inputs.determinate.url = "github:DeterminateSystems/determinate";
  flake.modules.nixos.determinate-nix.imports = [
    inputs.determinate.nixosModules.default
  ];
}
