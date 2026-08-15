{
  flake.modules.nixos.dev = {
    # Enable tailscale
    services.tailscale.enable = true;
  };
}
