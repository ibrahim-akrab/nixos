{ config, ... }:
{
  flake.modules.nixos."hosts/apollo" = {
    imports = [ config.flake.modules.nixos.facter ];
    facter.reportPath = ./facter.json;
  };
}
