{
  flake.modules.homeManager.hyprland =
    { pkgs, ... }:
    {
      home.pointerCursor = {
        gtk.enable = true;
        package = pkgs.quintom-cursor-theme;
        hyprcursor.enable = true;
        name = "Quintom_Ink";
        size = 24;
      };

    };
}
