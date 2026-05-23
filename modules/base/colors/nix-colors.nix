{ inputs, ... }:
{
  flake-file.inputs.nix-colors = {
    url = "github:misterio77/nix-colors";
    inputs.nixpkgs-lib.follows = "nixpkgs-lib";
  };

  flake.modules = {
    nixos.base = { };

    homeManager.base = {
      imports = [
        inputs.nix-colors.homeManagerModules.default
      ];

      colorScheme = inputs.nix-colors.colorSchemes.dracula;
    };
  };
}
