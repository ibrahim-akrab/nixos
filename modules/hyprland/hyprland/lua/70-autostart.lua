local cursor = require("nix.cursor")

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/
local function reloadWaybar()
    hl.exec_cmd("pkill -SIGUSR2 waybar || waybar")
end

hl.on("hyprland.start", function()
    hl.exec_cmd("hyprsunset")
    hl.exec_cmd("systemctl --user start hyprpolkitage")
    -- clipboard daemons live in ../../clipboard.nix as systemd user services
    hl.exec_cmd("hyprctl setcursor " .. cursor.name .. " " .. cursor.size)
    reloadWaybar()
end)

hl.on("config.reloaded", reloadWaybar)
