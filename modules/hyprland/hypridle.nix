{
  flake.modules.homeManager.hyprland =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.hypridle ];
      services.hypridle = {
        enable = true;
        settings = {
          general = {
            lock_cmd = "pidof hyprlock || hyprlock";
            before_sleep_cmd = "loginctl lock-session";
            after_sleep_cmd = "hyprctl dispatch dpms on";
          };
          listener = [
            {
              timeout = 900;
              on-timeout = "loginctl lock-session";
            }
            {
              timeout = 930;
              on-timeout = "hyprctl dispatch dpms off";
              on-resume = "hyprctl dispatch dpms on && brightnessctl -r";
            }
          ];
        };
      };
    };
}
