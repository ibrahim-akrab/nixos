{
  flake.modules.nixos.base =
    { pkgs
    , lib
    , ...
    }:
    {
      # Use latest kernel
      boot.kernelPackages = lib.mkDefault pkgs.linuxPackages_latest;
    };
}
