{
  flake.modules.homeManager.hyprland =
    {
      lib,
      ...
    }:
    {
      wayland.windowManager.hyprland.settings = {
        # Default applications
        "$terminal" = lib.mkDefault "kitty";
        "$fileManager" = lib.mkDefault "dolphin --new-window";
        "$browser" = lib.mkDefault "librewolf --new-window";
        # "$music" = lib.mkDefault "spotify";
        "$passwordManager" = lib.mkDefault "bitwarden";
        "$messenger" = lib.mkDefault "telegram";
        "$webapp" = lib.mkDefault "$browser --app";

        # monitor = cfg.monitors;
        debug = {
          disable_logs = false;
        };
      };
    };
}
