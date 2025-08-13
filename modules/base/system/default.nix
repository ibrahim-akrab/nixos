{ lib, ... }:
{
  flake.modules = {
    nixos.base = {
      system = {
        # See https://github.com/NixOS/nixpkgs/pull/415640
        rebuild.enableNg = lib.mkDefault true;
      };
    };
  };
}
