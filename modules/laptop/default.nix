{
  flake.modules = {
    nixos.laptop = {
      # Common laptop configuration
      services.hardware.bolt.enable = true;
      hardware.sensor.iio.enable = true;
    };
    homeManager.laptop =
      { pkgs, ... }:
      {
        home.packages = [
          pkgs.brightnessctl # Screen brightness control
        ];
      };
  };
}
