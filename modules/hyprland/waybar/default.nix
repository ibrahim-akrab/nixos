{
  flake.modules = {
    nixos.hyprland = {
      services.blueman.enable = true; # handy program for managing bluetooth connections
    };

    homeManager.hyprland =
      {
        inputs,
        config,
        ...
      }:
      let
        palette = config.colorScheme.palette;
        convert = inputs.nix-colors.lib.conversions.hexToRGBString;
        backgroundRgb = "rgb(${convert ", " palette.base00})";
        foregroundRgb = "rgb(${convert ", " palette.base05})";
        colored_bar_icons = [
          "<span color='#00ff6e'>▁</span>" # green
          "<span color='#4cff4c'>▂</span>" # yellow-green
          "<span color='#99ff29'>▃</span>" # lime
          "<span color='#e6ff05'>▄</span>" # yellow
          "<span color='#ffd100'>▅</span>" # amber
          "<span color='#ff8d00'>▆</span>" # orange
          "<span color='#ff4900'>▇</span>" # red-orange
          "<span color='#ff0500'>█</span>" # red
        ];
      in
      {
        home.file = {
          ".config/waybar/style.css" = {
            source = ./style.css;
          };
          ".config/waybar/theme.css" = {
            text = ''
              @define-color background ${backgroundRgb};
              * {
                color: ${foregroundRgb};
              }

              window#waybar {
                background-color: ${backgroundRgb};
              }
            '';
          };
        };

        programs.waybar = {
          enable = true;
          settings = [
            {
              layer = "top";
              position = "top";
              spacing = 0;
              height = 26;
              modules-left = [
                "hyprland/workspaces"
              ];
              modules-center = [
                "clock"
              ];
              modules-right = [
                "tray"
                "network"
                "bluetooth"
                "wireplumber"
                "cpu"
                "memory"
                "systemd-failed-units"
                "battery"
                "group/group-power"
              ];
              "hyprland/workspaces" = {
                on-click = "activate";
                format = "{icon}";
                format-icons = {
                  default = "";
                  "1" = "1";
                  "2" = "2";
                  "3" = "3";
                  "4" = "4";
                  "5" = "5";
                  "6" = "6";
                  "7" = "7";
                  "8" = "8";
                  "9" = "9";
                  "10" = "10";
                  active = "󱓻";
                  urgent = "󱨇";
                };
                persistent-workspaces = {
                  "*" = 5;
                };
              };
              cpu = {
                interval = 1;
                format = "{icon}󰍛";
                format-icons = colored_bar_icons;
                on-click = "kitty -e btop";
              };
              memory = {
                format = "{icon}";
                on-click = "kitty -e btop";
                format-icons = colored_bar_icons;
                tooltip-format = "{used:0.1f}/{total:0.0f} GB ({percentage}%)";

              };
              clock = {
                format = "{:%A %I:%M %p}";
                format-alt = "{:%d %B W%V %Y}";
                tooltip = false;
              };

              systemd-failed-units = {
                hide-on-ok = true;
                format = "{nr_failed}✗";
              };
              network = {
                format-icons = [
                  "󰤯"
                  "󰤟"
                  "󰤢"
                  "󰤥"
                  "󰤨"
                ];
                format = "{icon}";
                format-wifi = "{icon}";
                format-ethernet = "󰀂";
                format-disconnected = "󰖪";
                tooltip-format-wifi = "{essid} ({frequency} GHz)\n⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
                tooltip-format-ethernet = "⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
                tooltip-format-disconnected = "Disconnected";
                interval = 3;
                nospacing = 1;
                on-click = "kitty -e nmtui";
              };
              battery = {
                interval = 5;
                format = "{capacity}% {icon}";
                format-discharging = "{icon}";
                format-charging = "{icon}";
                format-plugged = "";
                format-icons = {
                  charging = [
                    "󰢜"
                    "󰂆"
                    "󰂇"
                    "󰂈"
                    "󰢝"
                    "󰂉"
                    "󰢞"
                    "󰂊"
                    "󰂋"
                    "󰂅"
                  ];
                  default = [
                    "󰂎"
                    "󰁺"
                    "󰁻"
                    "󰁼"
                    "󰁽"
                    "󰁾"
                    "󰁿"
                    "󰂀"
                    "󰂁"
                    "󰂂"
                    "󰁹"
                  ];
                };
                format-full = "Charged ";
                tooltip-format-discharging = "{power:>1.0f}W↓ {capacity}%";
                tooltip-format-charging = "{power:>1.0f}W↑ {capacity}%";
                tooltip-format-plugged = "{capacity}%";
                states = {
                  warning = 20;
                  critical = 10;
                };
              };
              bluetooth = {
                format = "󰂯";
                format-disabled = "󰂲";
                format-connected = "󰂱";

                tooltip-format = "{num_connections} connected";
                tooltip-format-connected = "{num_connections} connected\n\n{device_enumerate}";
                tooltip-format-enumerate-connected-battery = "{device_alias}\t{device_battery_percentage}%";
                on-click = "blueman-manager";
              };
              wireplumber = {
                # Changed from "pulseaudio"
                format = "{icon}";
                format-muted = "";
                format-icons = [
                  " "
                  " "
                  " "
                  " "
                ];
                scroll-step = 5;
                on-click = "pavucontrol";
                tooltip-format = "{volume}%";
                on-click-right = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"; # Updated command
                max-volume = 150; # Optional: allow volume over 100%
              };
              "group/group-power" = {
                orientation = "inherit";
                drawer = {
                  transition-duration = 500;
                  transition-left-to-right = false;
                };
                modules = [
                  "custom/shutdown"
                  "custom/lock"
                  "custom/reboot"
                  "custom/sleep"
                  "custom/hibernate"
                ];
              };
              "custom/hibernate" = {
                format = "⏼";
                tooltip-format = "hibernate";
                on-click = "systemctl hibernate";
              };
              "custom/sleep" = {
                format = "󰒲";
                tooltip-format = "sleep";
                on-click = "systemctl hybrid-sleep";
              };
              "custom/lock" = {
                format = "";
                tooltip-format = "lock";
                on-click = "hyprlock";
              };
              "custom/reboot" = {
                format = "";
                tooltip-format = "reboot";
                on-click = "reboot";
              };
              "custom/shutdown" = {
                format = "";
                tooltip-format = "shutdown";
                on-click = "shutdown now";
              };
              tray = {
                spacing = 13;
              };
            }
          ];
        };
      };
  };
}
