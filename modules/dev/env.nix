{
  flake.modules.homeManager.dev = {
    home.sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };

    home.shellAliases = {
      ".." = "cd ..";
      "..." = "cd ../..";
      #"ls" = "lsd";
      #"l" = "lsd";
      #"ll" = "lsd -l";
      #"la" = "lsd -la";
    };
  };
}
