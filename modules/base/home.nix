{ inputs, lib, ... }:
{

  flake-file.inputs.home-manager = {
    url = "github:nix-community/home-manager";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  flake.modules = {
    nixos.base = {

      imports = [ inputs.home-manager.nixosModules.home-manager ];
      home-manager.useGlobalPkgs = lib.mkDefault true;
      home-manager.useUserPackages = lib.mkDefault true;
      home-manager.backupFileExtension = lib.mkDefault "backup";
    };
    homeManager.base =
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
        home.stateVersion = lib.mkDefault osConfig.system.stateVersion;
      };
  };
}
