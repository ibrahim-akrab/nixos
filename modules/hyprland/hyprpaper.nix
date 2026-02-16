{
  flake.modules.homeManager.hyprland = {
    services.hyprpaper = {
      enable = true;
      settings = {
        splash = false;
        wallpaper = [
          {
            monitor = ""; # Empty monitor means fallback/default for all monitors
            path = "${./wallpaper.jpg}";
          }
        ];
      };
    };
  };
}
