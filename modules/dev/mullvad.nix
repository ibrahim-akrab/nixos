{
  flake.modules.nixos.dev = {
    services.mullvad-vpn = {
      enable = true;
      gui.enable = true;
    };
  };
}
