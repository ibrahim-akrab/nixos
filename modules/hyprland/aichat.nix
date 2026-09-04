{
  flake.modules.homeManager.hyprland = { pkgs, ... }:
    let
      specialTitle = "aichat-special-terminal";
      # Geometry rules are muParser expressions; `%` is not a token, so sizes go
      # through monitor_w / monitor_h. `center` centers within the work area.
      geometry = "size monitor_w*2/3 monitor_h*2/3; center";
    in
    {
      home.packages = [ pkgs.aichat ];
      wayland.windowManager.hyprland.settings = {
        exec-once = [
          "[workspace special:aichat silent; float; ${geometry}] $terminal -T ${specialTitle} --hold sh -c 'while true; do aichat; clear; done'"
        ];
        windowrule = [ "workspace special:aichat, match:title ${specialTitle}" ];
        bind = [
          # mapping aichat to the windows assistant key
          "SUPER SHIFT, code:201, togglespecialworkspace, aichat"
        ];
      };
    };
}
