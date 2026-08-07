{
  flake.modules.nixos.base =
    { lib
    , ...
    }:
    {
      services.cloudflare-warp = {
        enable = lib.mkDefault true;
      };
    };
}
