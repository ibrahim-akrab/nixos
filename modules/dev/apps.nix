{
  flake.modules.homeManager.dev =
    {
      pkgs,
      ...
    }:
    {
      home.packages = with pkgs; [
        slack
        telegram-desktop

        tree
        cht-sh
        wget
        git
      ];
    };
}
