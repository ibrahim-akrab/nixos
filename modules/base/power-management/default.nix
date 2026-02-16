{
  flake.modules = {
    nixos.base =
      { lib
      , ...
      }:
      {
        powerManagement.powertop.enable = lib.mkDefault true;
        services.acpid.enable = lib.mkDefault true;
      };
    homeManager.base =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          acpi
          powertop # Power consumption analysis
        ];
      };
  };
}
