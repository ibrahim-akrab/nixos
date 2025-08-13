{ lib, ... }:
{
  flake.modules.nixos.base = {
    security.rtkit.enable = lib.mkDefault true;
  };
}
