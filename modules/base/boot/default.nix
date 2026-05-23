{ lib, ... }:
{
  flake.modules.nixos.base.boot = {
    loader.systemd-boot.enable = lib.mkDefault true;
  };
}
