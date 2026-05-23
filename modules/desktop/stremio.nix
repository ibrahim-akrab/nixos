{
  flake.modules = {
    homeManager.desktop =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.stremio-linux-shell ];
      };
  };

}
