{
  flake-file = {
    description = "Ibrahim's Nix Environment";
  };

  flake.modules.nixos.base =
    { inputs
    , pkgs
    , lib
    , ...
    }:
    {
      nix = {
        # See https://discourse.nixos.org/t/24-05-add-flake-to-nix-path/46310/9
        # See https://hachyderm.io/@leftpaddotpy/112539055867932912
        channel.enable = lib.mkDefault false;
        settings.nix-path = [ "nixpkgs=${pkgs.path}" ];

        # From https://jackson.dev/post/nix-reasonable-defaults/
        extraOptions = ''
          connect-timeout = 5
          log-lines = 50
          min-free = 128000000
          max-free = 1000000000
          fallback = true
        '';
        optimise.automatic = lib.mkDefault true;
        settings = {
          trusted-users = [
            "root"
            "@wheel"
          ];
          auto-optimise-store = lib.mkDefault true;
          experimental-features = [
            "nix-command"
            "flakes"
          ];

          # Substituters for binary caches
          substituters = lib.mkDefault [
            "https://cache.nixos.org/"
            "https://nix-community.cachix.org"
          ];

          trusted-public-keys = lib.mkDefault [
            "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
            "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          ];

          warn-dirty = lib.mkDefault false;
          tarball-ttl = lib.mkDefault (60 * 60 * 24);
        };

        # Garbage collection
        gc = {
          automatic = lib.mkDefault true;
          dates = lib.mkDefault "weekly";
          options = lib.mkDefault "--delete-older-than 30d";
        };

        # Registry for flakes
        registry = {
          nixpkgs.flake = inputs.nixpkgs;
        };
      };

      # Allow unfree packages globally
      nixpkgs.config.allowUnfree = true;
    };
}
