{ lib, ... }:
{
  flake.modules = {
    nixos.base = {
      programs.command-not-found.enable = lib.mkDefault false;
    };

    homeManager.base = {
      programs.command-not-found.enable = lib.mkDefault false;
    };
  };
}
