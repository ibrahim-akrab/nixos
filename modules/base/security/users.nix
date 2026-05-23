{
  flake.modules.nixos.base =
    { lib, ... }:
    {
      users.mutableUsers = lib.mkDefault false;
    };
}
