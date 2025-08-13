{
  flake.modules.homeManager.hyprland = {
    services.hyprpaper = {
      enable = true;
      settings = {
        preload = [
          (builtins.toString ./wallpaper.jpg)
        ];
        wallpaper = [
          ",${builtins.toString ./wallpaper.jpg}"
        ];
      };
    };
  };
}
