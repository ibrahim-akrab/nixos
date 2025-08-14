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
                # "custom/dropbox"
                "tray"
                "network"
                "bluetooth"
                "wireplumber"
                "cpu"
                "memory"
                "power-profiles-daemon"
                "battery"
              ];
              "hyprland/workspaces" = {
                on-click = "activate";
                format = "{icon}";
                format-icons = {
                  default = "";
                  "0" = "0";
                  "1" = "1";
                  "2" = "2";
                  "3" = "3";
                  "4" = "4";
                  "5" = "5";
                  "6" = "6";
                  "7" = "7";
                  "8" = "8";
                  "9" = "9";
                  active = "󱓻";
                };
                persistent-workspaces = {
                  "1" = [ ];
                  "2" = [ ];
                  "3" = [ ];
                  "4" = [ ];
                  "5" = [ ];
                };
              };
              cpu = {
                interval = 5;
                format = "󰍛";
                on-click = "kitty -e btop";
              };
              memory = {
                format = "  ";
                on-click = "kitty -e btop";

              };
              clock = {
                format = "{:%A %I:%M %p}";
                format-alt = "{:%d %B W%V %Y}";
                tooltip = false;
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
                tooltip-format = "Devices connected: {num_connections}";
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
              tray = {
                spacing = 13;
              };
              # power-profiles-daemon = {
              #   format = "{icon}";
              #   tooltip-format = "Power profile: {profile}";
              #   tooltip = true;
              #   format-icons = {
              #     power-saver = "󰡳";
              #     balanced = "󰊚";
              #     performance = "󰡴";
              #   };
              # };
              # "custom/dropbox" = {
              #   format = "";
              #   on-click = "nautilus ~/Dropbox";
              #   exec = "dropbox-cli status";
              #   return-type = "text";
              #   interval = 5;
              #   tooltip = true;
              #   tooltip-format = "{}";
              # };
            }
          ];
        };
      };
  };
}
