{
  flake.modules.homeManager.apollo =
    { inputs, pkgs, ... }:
    {
      home.packages = [
        inputs.self.packages.${pkgs.stdenv.hostPlatform.system}.battery-charge-limit
      ];
    };
}
