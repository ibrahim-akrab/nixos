{
  flake.modules.homeManager.dev = {
    # Commandline Tools
    programs.htop.enable = true;
    programs.btop.enable = true;
    programs.bat.enable = true;
    programs.bash.enable = true;
    programs.lsd = {
      enable = true;
      enableBashIntegration = true;
    };
    programs.zoxide = {
      enable = true;
      enableBashIntegration = true;
      options = [ "--cmd cd" ];
    };
    programs.direnv = {
      enable = true;
      enableBashIntegration = true;
      silent = true;
    };
  };
}
