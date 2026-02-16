{
  flake.modules = {
    homeManager.desktop =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.stremio ];
      };
    nixos.desktop = { pkgs, lib, ... }: {
      nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
        "stremio-shell"
      ];
      nixpkgs.config.permittedInsecurePackages = [
        "qtwebengine-5.15.19"
      ];
    };
  };

}
