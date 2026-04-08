{
  flake.modules.homeManager.desktop =
    {
      programs.zathura = {
        enable = true;
        extraConfig = "set selection-clipboard clipboard";
      };
    };
}
