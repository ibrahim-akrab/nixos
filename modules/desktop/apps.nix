{
  flake.modules.homeManager.desktop =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        droidcam
        stremio
        vlc
      ];
    };
}
