{ lib, ... }:
{
  flake.modules.homeManager.base =
    { osConfig, ... }:
    {
      programs.home-manager.enable = lib.mkDefault true;
      # See https://ohai.social/@rycee/112502545466617762
      # See https://github.com/nix-community/home-manager/issues/5452
      systemd.user.startServices = lib.mkDefault "sd-switch";

      home.shell.enableBashIntegration = true;

      services = {
        home-manager.autoExpire = {
          enable = lib.mkDefault true;
          frequency = lib.mkDefault "weekly";
          store.cleanup = lib.mkDefault true;
        };
      };
      nixpkgs.config.allowUnfree = true;
      home.stateVersion = lib.mkDefault osConfig.system.stateVersion;
    };
}
