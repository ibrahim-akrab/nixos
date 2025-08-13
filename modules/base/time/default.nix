{
  flake.modules.nixos.base =
    { lib, ... }:
    {
      time.timeZone = lib.mkDefault "Asia/Manila";
    };
}
