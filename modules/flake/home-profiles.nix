{ inputs
, config
, ...
}:
let
  my_modules = [
    "audio"
    "base"
    "dev"
    "desktop"
    "hyprland"
  ];

  homeManagerModulesNames = builtins.filter
    (name: config.flake.modules.homeManager ? "${name}")
    my_modules;

  homeManagerModules = map
    (name: config.flake.modules.homeManager."${name}")
    homeManagerModulesNames;

  ibrahimMeta = config.flake.meta.users.ibrahim;
in
{
  flake.homeConfigurations.ibrahim = inputs.home-manager.lib.homeManagerConfiguration {
    pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
    extraSpecialArgs = { inherit inputs; };
    modules = homeManagerModules ++ [
      {
        home.username = ibrahimMeta.username;
        home.homeDirectory = "/home/${ibrahimMeta.username}";
      }
    ];
  };
}
