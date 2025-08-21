{
  flake.modules = {
    nixos.desktop = {
      programs.kdeconnect.enable = true;
    };
    homeManager.desktop = {
      services.kdeconnect = {
        enable = true;
        indicator = true;
      };
    };
  };
}
