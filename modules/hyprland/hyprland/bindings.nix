{
  flake.modules.homeManager.hyprland =
    {
      pkgs,
      ...
    }:
    let
      show-bindings = pkgs.writeShellScriptBin "show-bindings" (
        builtins.readFile ./hypr-show-bindings.sh
      );
    in
    {

      services.swayosd = {
        enable = true;
      };
      home.packages = with pkgs; [
        hyprshot
        hyprpicker
        clipse
      ];

      wayland.windowManager.hyprland.settings = {
        bind = [
          # "SUPER, A, exec, $webapp=https://chatgpt.com"
          # "SUPER SHIFT, A, exec, $webapp=https://grok.com"
          # "SUPER, C, exec, $webapp=https://app.hey.com/calendar/weeks/"
          # "SUPER, E, exec, $webapp=https://app.hey.com"
          # "SUPER, Y, exec, $webapp=https://youtube.com/"
          # "SUPER SHIFT, G, exec, $webapp=https://web.whatsapp.com/"
          # "SUPER, X, exec, $webapp=https://x.com/"
          # "SUPER SHIFT, X, exec, $webapp=https://x.com/compose/post"

          "SUPER, return, exec, $terminal"
          "SUPER, E, exec, $terminal -e $fileManager"
          "SUPER, B, exec, $browser"
          "SUPER, M, exec, $music"
          "SUPER, N, exec, $terminal -e nvim"
          "SUPER, T, exec, $terminal -e btop"
          # "SUPER, D, exec, $terminal -e lazydocker"
          "SUPER, G, exec, $messenger"
          # "SUPER, O, exec, obsidian -disable-gpu"
          "SUPER, slash, exec, $passwordManager"
          "SUPER, space, exec, wofi --show drun --sort-order=alphabetical"
          "SUPER SHIFT, SPACE, exec, pkill -SIGUSR1 waybar"
          # "SUPER CTRL, SPACE, exec, ~/.local/share/omarchy/bin/swaybg-next"
          # "SUPER SHIFT CTRL, SPACE, exec, ~/.local/share/omarchy/bin/omarchy-theme-next"

          "SUPER, W, killactive,"
          "SUPER, Backspace, killactive,"

          # End active session
          "SUPER, ESCAPE, exec, hyprlock"
          "SUPER SHIFT, ESCAPE, exit,"
          "SUPER CTRL, ESCAPE, exec, reboot"
          "SUPER SHIFT CTRL, ESCAPE, exec, systemctl poweroff"
          "SUPER SHIFT CTRL, H, exec, systemctl hibernate"
          "SUPER, K, exec, ${pkgs.lib.getExe show-bindings}"

          # Control tiling
          "SUPER, J, togglesplit, # dwindle"
          "SUPER, P, pseudo, # dwindle"
          "SUPER, V, togglefloating,"
          "SUPER, F, fullscreen,"

          # Move focus with mainMod + arrow keys
          "SUPER, left, movefocus, l"
          "SUPER, right, movefocus, r"
          "SUPER, up, movefocus, u"
          "SUPER, down, movefocus, d"

          # Switch workspaces with mainMod + [0-9]
          "SUPER, 1, workspace, 1"
          "SUPER, 2, workspace, 2"
          "SUPER, 3, workspace, 3"
          "SUPER, 4, workspace, 4"
          "SUPER, 5, workspace, 5"
          "SUPER, 6, workspace, 6"
          "SUPER, 7, workspace, 7"
          "SUPER, 8, workspace, 8"
          "SUPER, 9, workspace, 9"
          "SUPER, 0, workspace, 10"

          "SUPER, comma, workspace, -1"
          "SUPER, period, workspace, +1"

          # Move active window to a workspace with mainMod + SHIFT + [0-9]
          "SUPER SHIFT, 1, movetoworkspace, 1"
          "SUPER SHIFT, 2, movetoworkspace, 2"
          "SUPER SHIFT, 3, movetoworkspace, 3"
          "SUPER SHIFT, 4, movetoworkspace, 4"
          "SUPER SHIFT, 5, movetoworkspace, 5"
          "SUPER SHIFT, 6, movetoworkspace, 6"
          "SUPER SHIFT, 7, movetoworkspace, 7"
          "SUPER SHIFT, 8, movetoworkspace, 8"
          "SUPER SHIFT, 9, movetoworkspace, 9"
          "SUPER SHIFT, 0, movetoworkspace, 10"

          # Swap active window with the one next to it with mainMod + SHIFT + arrow keys
          "SUPER SHIFT, left, swapwindow, l"
          "SUPER SHIFT, right, swapwindow, r"
          "SUPER SHIFT, up, swapwindow, u"
          "SUPER SHIFT, down, swapwindow, d"

          # Resize active window
          "SUPER, minus, resizeactive, -100 0"
          "SUPER, equal, resizeactive, 100 0"
          "SUPER SHIFT, minus, resizeactive, 0 -100"
          "SUPER SHIFT, equal, resizeactive, 0 100"

          # Scroll through existing workspaces with mainMod + scroll
          "SUPER, mouse_down, workspace, e+1"
          "SUPER, mouse_up, workspace, e-1"

          # Super workspace floating layer
          "SUPER, S, togglespecialworkspace, magic"
          "SUPER SHIFT, S, movetoworkspace, special:magic"

          # Screenshots
          ", PRINT, exec, hyprshot -m region"
          "SHIFT, PRINT, exec, hyprshot -m window"
          "CTRL, PRINT, exec, hyprshot -m output"

          # Color picker
          "SUPER, PRINT, exec, hyprpicker -a"

          # Clipse
          "CTRL SUPER, V, exec, kitty --class clipse -e clipse"
        ];

        bindm = [
          # Move/resize windows with mainMod + LMB/RMB and dragging
          "SUPER, mouse:272, movewindow"
          "SUPER, mouse:273, resizewindow"
        ];

        bindel = [
          # Laptop multimedia keys for volume and LCD brightness
          ",XF86AudioRaiseVolume, exec, swayosd-client --output-volume raise"
          ",XF86AudioLowerVolume, exec, swayosd-client --output-volume lower"
          ",XF86AudioMute, exec, swayosd-client --output-volume mute-toggle"
          ",XF86AudioMicMute, exec, swayosd-client --input-volume mute-toggle"
          "SHIFT,XF86AudioRaiseVolume, exec, swayosd-client --input-volume raise"
          "SHIFT,XF86AudioLowerVolume, exec, swayosd-client --input-volume lower"
          ",XF86MonBrightnessUp, exec, swayosd-client --brightness raise"
          ",XF86MonBrightnessDown, exec, swayosd-client --brightness lower"
        ];

        bindl = [
          # Requires playerctl
          ", XF86AudioNext, exec, swayosd-client --playerctl next"
          ", XF86AudioPause, exec, swayosd-client --playerctl pause"
          ", XF86AudioPlay, exec, swayosd-client --playerctl play"
          ", XF86AudioPrev, exec, swayosd-client --playerctl prev"
          ",Caps_Lock, exec, sleep 0.2 && swayosd-client --caps-lock"
        ];
      };
    };
}
