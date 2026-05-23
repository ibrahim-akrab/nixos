{
  flake.modules.homeManager.dev = {
    programs.starship = {
      enable = true;
      enableBashIntegration = true;
      settings = {
        add_newline = false;
        line_break = {
          disabled = true;
        };
      };
    };
  };
}
