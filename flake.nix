# DO-NOT-EDIT. This file was auto-generated using github:vic/flake-file.
# Use `nix run .#write-flake` to regenerate it.
{
  description = "Ibrahim's Nix Environment";

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);

  inputs = {
    allfollow = {
      url = "github:spikespaz/allfollow";
    };
    disko = {
      url = "github:nix-community/disko";
    };
    flake-file = {
      url = "github:vic/flake-file";
    };
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
    };
    impermanence = {
      url = "github:nix-community/impermanence";
    };
    import-tree = {
      url = "github:vic/import-tree";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
    };
    nix-colors = {
      url = "github:misterio77/nix-colors";
    };
    nixos-facter-modules = {
      url = "github:nix-community/nixos-facter-modules";
    };
    nixos-wsl = {
      url = "github:nix-community/nixos-wsl";
    };
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixpkgs-unstable";
    };
    nixpkgs-lib = {
      follows = "nixpkgs";
    };
    systems = {
      url = "github:nix-systems/default";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
    };
  };

}
