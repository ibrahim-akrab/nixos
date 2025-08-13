{ lib, ... }:
{
  flake.modules.nixos.base = {
    programs.nh = {
      enable = lib.mkDefault true;
      flake = lib.mkDefault "/home/ibrahim/nixos";
    };
  };
}
