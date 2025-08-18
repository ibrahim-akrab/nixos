{
  flake.modules.homeManager.hyprland =
    {
    pkgs,
      lib,
      ...
    }:
    {
      wayland.windowManager.hyprland.settings = {
        # Default applications
        "$terminal" = lib.mkDefault "${lib.getExe pkgs.kitty}";
        "$fileManager" = lib.mkDefault "${lib.getExe pkgs.yazi}";
        "$browser" = lib.mkDefault "${lib.getExe pkgs.librewolf} --new-window";
        # "$music" = lib.mkDefault "spotify";
        "$passwordManager" = lib.mkDefault "${lib.getExe pkgs.bitwarden-desktop}";
        "$messenger" = lib.mkDefault "${lib.getExe pkgs.telegram-desktop}";
        "$webapp" = lib.mkDefault "$browser --app";
      };
    };
}
