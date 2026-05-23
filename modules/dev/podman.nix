{
  flake.modules = {
    nixos.dev = {
      virtualisation.podman = {
        enable = true;
        dockerCompat = true;
        dockerSocket.enable = true;
        defaultNetwork.settings.dns_enabled = true;
      };
    };

    homeManager.dev =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          lazydocker
          podman-compose
        ];
      };
  };
}
