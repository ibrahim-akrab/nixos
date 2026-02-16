{ inputs
, lib
, config
, ...
}:
let
  prefix = "hosts/";
  collectHostsModules = modules: lib.filterAttrs (name: _: lib.hasPrefix prefix name) modules;
in
{
  flake.nixosConfigurations = lib.pipe (collectHostsModules config.flake.modules.nixos) [
    (lib.mapAttrs' (
      name: module:
        let
          specialArgs = {
            inherit inputs;
            hostConfig = {
              name = lib.removePrefix prefix name;
            };
          };
        in
        {
          name = lib.removePrefix prefix name;
          value = inputs.nixpkgs.lib.nixosSystem {
            inherit specialArgs;
            modules = [
              module
              {
                home-manager.extraSpecialArgs = specialArgs;
              }
            ];
          };
        }
    ))
  ];
}
