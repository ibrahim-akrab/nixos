{
  flake-file.inputs.nixos-wsl.url = "github:nix-community/nixos-wsl";

  flake.modules.nixos.wsl =
    { lib, ... }:
    {
      # Enable WSL integration
      wsl = {
        enable = true;
        defaultUser = lib.mkDefault "ibrahim";

        # WSL-specific settings
        wslConf = {
          automount.root = "/mnt";
          network.generateHosts = false;
          network.generateResolvConf = false;
        };
      };

      # Disable services that don't work well in WSL
      systemd.services.systemd-udevd.enable = false;
      systemd.services.systemd-udev-trigger.enable = false;
    };
}
