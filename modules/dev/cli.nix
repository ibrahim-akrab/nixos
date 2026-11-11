{
  flake.modules.homeManager.dev =
    { pkgs
    , lib
    , ...
    }:
    {
      home.packages = (lib.optional pkgs.stdenv.hostPlatform.isx86_64 pkgs.slack) ++ (with pkgs; [
        tree
        cht-sh
        file
        wget
        git
        unzip
        dig
      ]);
    };
}
