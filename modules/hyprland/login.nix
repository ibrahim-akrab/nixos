{
  flake.modules.nixos.hyprland =
    { pkgs
    , lib
    , ...
    }:
    {
      services.greetd = {
        enable = true;
        settings.default_session.command = "${lib.getExe pkgs.tuigreet} --time --cmd start-hyprland --remember";
      };
    };
}
