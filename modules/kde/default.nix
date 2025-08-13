{
  flake.modules = {
    nixos.kde = {
      services.displayManager.sddm = {
        enable = true;
        wayland.enable = true;
      };
      services.desktopManager.plasma6.enable = true;
      programs.kdeconnect.enable = true;
    };
    homeManager.kde =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.lm_sensors ];
      };
  };
}
