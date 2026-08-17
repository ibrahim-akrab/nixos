{
  flake.modules.homeManager.hyprland =
    { pkgs, ... }:
    let
      # Both daemons only make sense once a wayland session exists, and both
      # should come back on their own if they stop -- a dead clipse listener is
      # silent otherwise (no history recorded until the next login).
      #
      # Restart=always, not on-failure: opening the clipse TUI (CTRL SUPER V)
      # makes the running listener exit *successfully*, which on-failure would
      # ignore, leaving the clipboard unrecorded after the first lookup.
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

        # -listen-shell, not -listen: the latter forks wl-paste watchers and
        # exits, so systemd would tear the watchers down with the main process.
        clipse = clipboardService
          "clipse clipboard history listener"
          "${pkgs.clipse}/bin/clipse -listen-shell";
      };
    };
}
