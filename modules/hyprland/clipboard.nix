{
  flake.modules.homeManager.hyprland =
    { pkgs, ... }:
    let
      # Both daemons only make sense once a wayland session exists, and both
      # should come back on their own if they stop -- a dead clipse listener is
      # silent otherwise (no history recorded until the next login).
      clipboardService = description: exec: {
        Unit = {
          Description = description;
          PartOf = [ "graphical-session.target" ];
          After = [ "graphical-session.target" ];
          ConditionEnvironment = "WAYLAND_DISPLAY";
        };
        Service = {
          ExecStart = exec;
          Restart = "always";
          RestartSec = 2;
        };
        Install.WantedBy = [ "graphical-session.target" ];
      };

      # `clipse -listen` spawns exactly these two watchers and exits, which
      # leaves systemd nothing to supervise. Run them directly instead.
      clipseWatcher = type:
        clipboardService
          "clipse clipboard history listener (${type})"
          "${pkgs.wl-clipboard}/bin/wl-paste --type ${type} --watch ${pkgs.clipse}/bin/clipse --wl-store";
    in
    {
      home.packages = with pkgs; [
        clipse
        wl-clip-persist
        wl-clipboard
      ];

      systemd.user.services = {
        wl-clip-persist = clipboardService
          "Keep clipboard contents alive after the source window closes"
          "${pkgs.wl-clip-persist}/bin/wl-clip-persist --clipboard regular";

        clipse-text = clipseWatcher "text";
        clipse-image = clipseWatcher "image/png";
      };
    };
}
