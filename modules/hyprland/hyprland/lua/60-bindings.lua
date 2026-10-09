local apps    = require("nix.apps")
local scripts = require("nix.scripts")

local mainMod = "SUPER"

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + return", hl.dsp.exec_cmd(apps.terminal))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(apps.fileManager))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(apps.browser))
-- hl.bind(mainMod .. " + M", hl.dsp.exec_cmd(apps.music))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd(apps.terminal .. " -e nvim"))
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(apps.terminal .. " -e btop"))
hl.bind(mainMod .. " + G", hl.dsp.exec_cmd(apps.messenger))
hl.bind(mainMod .. " + slash", hl.dsp.exec_cmd(apps.passwordManager))
hl.bind(mainMod .. " + space", hl.dsp.exec_cmd("wofi --show drun --sort-order=alphabetical"))
hl.bind(mainMod .. " + SHIFT + SPACE", hl.dsp.exec_cmd("pkill -SIGUSR1 waybar"))

hl.bind(mainMod .. " + W", hl.dsp.window.close())
hl.bind(mainMod .. " + Backspace", hl.dsp.window.close())

-- End active session
hl.bind(mainMod .. " + ESCAPE", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + SHIFT + ESCAPE", hl.dsp.exit())
hl.bind(mainMod .. " + CTRL + ESCAPE", hl.dsp.exec_cmd("reboot"))
hl.bind(mainMod .. " + SHIFT + CTRL + ESCAPE", hl.dsp.exec_cmd("systemctl poweroff"))
hl.bind(mainMod .. " + SHIFT + CTRL + H", hl.dsp.exec_cmd("systemctl hibernate"))
hl.bind(mainMod .. " + K", hl.dsp.exec_cmd(scripts.showBindings))

-- Control tiling
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit")) -- dwindle only
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())       -- dwindle only
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())

-- Move focus and swap windows with mainMod (+ SHIFT) + arrow keys
for _, dir in ipairs({ "left", "right", "up", "down" }) do
    hl.bind(mainMod .. " + " .. dir, hl.dsp.focus({ direction = dir }))
    hl.bind(mainMod .. " + SHIFT + " .. dir, hl.dsp.window.swap({ direction = dir }))
end

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + comma", hl.dsp.focus({ workspace = "-1" }))
hl.bind(mainMod .. " + period", hl.dsp.focus({ workspace = "+1" }))

-- Resize active window
hl.bind(mainMod .. " + minus", hl.dsp.window.resize({ x = -100, y = 0, relative = true }))
hl.bind(mainMod .. " + equal", hl.dsp.window.resize({ x = 100, y = 0, relative = true }))
hl.bind(mainMod .. " + SHIFT + minus", hl.dsp.window.resize({ x = 0, y = -100, relative = true }))
hl.bind(mainMod .. " + SHIFT + equal", hl.dsp.window.resize({ x = 0, y = 100, relative = true }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Screenshots
hl.bind("PRINT", hl.dsp.exec_cmd("hyprshot -m region"))
hl.bind("SHIFT + PRINT", hl.dsp.exec_cmd("hyprshot -m window"))
hl.bind("CTRL + PRINT", hl.dsp.exec_cmd("hyprshot -m output"))

-- Color picker
hl.bind(mainMod .. " + PRINT", hl.dsp.exec_cmd("hyprpicker -a"))

-- Clipse
hl.bind("CTRL + " .. mainMod .. " + V", hl.dsp.exec_cmd("kitty --class clipse -e clipse"))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
local volumeAndBrightness = { locked = true, repeating = true }

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("swayosd-client --output-volume raise"), volumeAndBrightness)
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("swayosd-client --output-volume lower"), volumeAndBrightness)
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("swayosd-client --output-volume mute-toggle"), volumeAndBrightness)
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("swayosd-client --input-volume mute-toggle"), volumeAndBrightness)
hl.bind("SHIFT + XF86AudioRaiseVolume", hl.dsp.exec_cmd("swayosd-client --input-volume raise"), volumeAndBrightness)
hl.bind("SHIFT + XF86AudioLowerVolume", hl.dsp.exec_cmd("swayosd-client --input-volume lower"), volumeAndBrightness)
hl.bind(
    "XF86MonBrightnessUp",
    hl.dsp.exec_cmd("swayosd-client --custom-progress=$(brightnessctl s +5% -n1 -e2 -m | awk -F, '{print $4/100}') --custom-progress-text=󰖨"),
    volumeAndBrightness
)
hl.bind(
    "XF86MonBrightnessDown",
    hl.dsp.exec_cmd("swayosd-client --custom-progress=$(brightnessctl s 5%- -n1 -e2 -m | awk -F, '{print $4/100}') --custom-progress-text=󰖨"),
    volumeAndBrightness
)

-- Requires playerctl
local locked = { locked = true }

hl.bind("XF86AudioNext", hl.dsp.exec_cmd("swayosd-client --playerctl next"), locked)
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("swayosd-client --playerctl pause"), locked)
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("swayosd-client --playerctl play"), locked)
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("swayosd-client --playerctl prev"), locked)
hl.bind("Caps_Lock", hl.dsp.exec_cmd("sleep 0.2 && swayosd-client --caps-lock"), locked)
