{ lib, ... }:
{
  flake.modules.nixos.base = {
    security.sudo-rs.enable = lib.mkDefault true;
    security.sudo-rs.wheelNeedsPassword = lib.mkDefault false; # Use 'sudo' without a password
  };
}
