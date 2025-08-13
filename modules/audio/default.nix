{
  flake.modules = {
    nixos.audio = {
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };
    };
    homeManager.audio =
      { pkgs, ... }:
      {
        home.packages = [ pkgs.pavucontrol ];
      };
  };
}
