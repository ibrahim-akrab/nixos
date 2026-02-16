{
  flake.modules.nixos.base =
    { hostConfig
    , lib
    , ...
    }:
    {
      networking = {
        hostName = hostConfig.name;

        networkmanager = {
          # Easiest to use and most distros use this by default.
          enable = lib.mkDefault true;
          # mac address masking for fingerprinting resistance
          wifi.macAddress = lib.mkDefault "stable-ssid";
          ethernet.macAddress = lib.mkDefault "stable";
        };
      };

      systemd = {
        # get around issue nixos/nixpkgs#180175
        services.NetworkManager-wait-online.enable = lib.mkDefault false;
        network.wait-online.enable = lib.mkDefault false;
      };

      services.resolved = {
        enable = lib.mkDefault true;
      };
    };
}
