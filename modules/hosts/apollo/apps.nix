{
  flake.modules.homeManager.apollo =
    { inputs, pkgs, ... }:
    {
      home.packages = [
        inputs.self.packages.${pkgs.system}.set-charge-limit
      ];
    };
}
