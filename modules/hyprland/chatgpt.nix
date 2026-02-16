{
  flake.modules.homeManager.hyprland = { pkgs, ... }:
    let
      specialTitle = "chatgpt-special-terminal";
      size = 70;
      offset = (100 - size) / 2;
    in
    {
      home.packages = [ pkgs.chatgpt-cli ];
      wayland.windowManager.hyprland.settings = {
        exec-once = [
          "[workspace special:chatgpt silent; float; move ${toString offset}% ${toString offset}%; size ${toString size}% ${toString size}%] $terminal -T ${specialTitle} --hold sh -c 'while true; do chatgpt; clear; done'"
        ];
        windowrule = [ "workspace special:chatgpt, match:title ${specialTitle}" ];
        bind = [
          # mapping chatgpt to the windows assistant key
          "SUPER SHIFT, code:201, togglespecialworkspace, chatgpt"
        ];
      };
    };
}
