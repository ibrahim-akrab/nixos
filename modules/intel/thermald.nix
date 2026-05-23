{
  flake.modules.nixos.intel = {
    # Enable thermald
    services.thermald.enable = true;
  };
}
