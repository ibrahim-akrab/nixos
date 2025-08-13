{
  flake.modules = {
    nixos.battery = {
      # Better battery life
      services.tlp = {
        enable = true;
        settings = {
          # START_CHARGE_THRESH_BAT0 = 20;
          # STOP_CHARGE_THRESH_BAT0 = 80;
          CPU_BOOST_ON_AC = 1;
          CPU_BOOST_ON_BAT = 0;
          CPU_SCALING_GOVERNOR_ON_AC = "performance";
          CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
        };
      };
    };
    homeManager.battery =
      { pkgs, ... }:
      {
        home.packages = [
          pkgs.upower
        ];
      };
  };
}
