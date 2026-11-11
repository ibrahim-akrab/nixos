{ inputs, ... }:
{
  flake-file.inputs.mobile-nixos = {
    url = "github:mobile-nixos/mobile-nixos/development";
    flake = false;
  };
  flake-file.inputs.alioth-device = {
    url = "github:ibrahim-akrab/alioth-device";
    flake = false;
  };

  flake.modules.nixos.alioth.imports = [
    (import (inputs.mobile-nixos + "/lib/configuration.nix") { device = null; })
    (inputs.alioth-device + "/devices/xiaomi-alioth/standalone.nix")
    ({ lib, ... }: {
      nixpkgs.hostPlatform = "aarch64-linux";
      nixpkgs.config.allowUnfree = true;
      nixpkgs.overlays = lib.mkAfter [
        (_: prev: {
          gadget-tool = prev.gadget-tool.overrideAttrs (old: {
            cmakeFlags = (old.cmakeFlags or [ ]) ++ [ "-DCMAKE_POLICY_VERSION_MINIMUM=3.5" ];
          });
        })
      ];
      mobile.device.enableFirmware = lib.mkForce true;
      boot.loader.systemd-boot.enable = lib.mkForce false;
    })
  ];
}
