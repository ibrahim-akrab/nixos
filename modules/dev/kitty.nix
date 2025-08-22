{
  flake.modules.homeManager.dev =
    { pkgs, ... }:
    {
      programs.kitty = {
        enable = true;
        font.name = "FiraCode";
        font.size = 12;
        shellIntegration.enableBashIntegration = true;
        themeFile = "Catppuccin-Mocha";
        settings = {
          confirm_os_window_close = 0;
          background_opacity = 0.7;
          copy_on_select = "clipboard";
        };
      };
      fonts.fontconfig.enable = true;
      home.packages = with pkgs; [
        nerd-fonts.fira-code
        nerd-fonts.droid-sans-mono
      ];
    };
}
