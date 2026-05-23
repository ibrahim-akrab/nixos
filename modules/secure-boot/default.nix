{
  flake-file.inputs.lanzaboote = {
    url = "github:nix-community/lanzaboote/v1.0.0";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.modules = {
    nixos.secure-boot =
      { lib
      , inputs
      , ...
      }:
      {
        imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];
        boot = {
          # Secure boot configuration
          bootspec.enable = true;
          loader.systemd-boot.enable = lib.mkForce false;
          loader.systemd-boot.configurationLimit = 5;
          loader.timeout = 2;

          lanzaboote = {
            enable = true;
            pkiBundle = "/var/lib/sbctl";
          };
        };
      };
    homeManager.secure-boot =
      { pkgs, ... }:
      {
        home.packages = [
          pkgs.sbctl
        ];
      };
  };
}
