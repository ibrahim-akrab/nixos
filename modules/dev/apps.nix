{
  flake.modules.homeManager.dev = {
    # Commandline Tools
    programs = {
      htop.enable = true;
      btop.enable = true;
      bat.enable = true;
      bash.enable = true;
      jq.enable = true;
      jqp.enable = true;
      ripgrep.enable = true;
      fd.enable = true;
      lazygit.enable = true;
      yazi = {
        enable = true;
        enableBashIntegration = true;
      };
      lsd = {
        enable = true;
        enableBashIntegration = true;
      };
      zoxide = {
        enable = true;
        enableBashIntegration = true;
        options = [ "--cmd cd" ];
      };
      direnv = {
        enable = true;
        enableBashIntegration = true;
        silent = true;
      };
    };
  };
}
