{
  flake.modules.nixos.base =
    {
      boot.kernelParams = [
        "zswap.enabled=1"
        "zswap.compressor=lz4"
        "zswap.max_pool_percent=25"
        "zswap.shrinker_enabled=Y"
      ];
    };
}
