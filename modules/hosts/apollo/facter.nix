{ config, ... }:
{
  flake.modules.nixos.apollo = {
    imports = [ config.flake.modules.nixos.facter ];
    facter.reportPath = ./facter.json;
  };
}
