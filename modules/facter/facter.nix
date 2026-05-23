{ inputs, ... }:
{
  flake-file.inputs.nixos-facter-modules.url = "github:nix-community/nixos-facter-modules";

  flake.modules = {
    nixos.facter =
      { ... }:
      {
        imports = [
          inputs.nixos-facter-modules.nixosModules.facter
        ];
        facter.detected.dhcp.enable = false;
      };
    homeManager.facter =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [ nixos-facter ];
      };
  };
}
