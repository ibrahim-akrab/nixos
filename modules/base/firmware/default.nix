{
  flake.modules.nixos.base =
    {
      pkgs,
      lib,
      ...
    }:
    {
      services.fwupd.enable = lib.mkDefault true; # Firmware updates
      hardware.enableAllFirmware = lib.mkDefault true;
      nixpkgs.config.allowUnfree = lib.mkDefault true; # enableAllFirmware depends on this
      hardware.firmware = [ pkgs.linux-firmware ];
    };
}
