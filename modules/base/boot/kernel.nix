{
  flake.modules.nixos.base =
    { pkgs
    , lib
    , ...
    }:
    {
      # Use latest kernel
      boot.kernelPackages = lib.mkOptionDefault pkgs.linuxPackages_latest;
    };
}
