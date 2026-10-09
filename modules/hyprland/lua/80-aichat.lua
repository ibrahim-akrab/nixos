local apps = require("nix.apps")

local specialTitle = "aichat-special-terminal"

hl.on("hyprland.start", function()
    hl.exec_cmd(apps.terminal .. " -T " .. specialTitle .. " --hold sh -c 'while true; do aichat --session; clear; done'")
end)

hl.window_rule({
    name  = "aichat-special",
    match = { title = specialTitle },

    workspace = "special:aichat silent",
    float     = true,
    size      = "monitor_w*2/3 monitor_h*2/3",
    center    = true,
})

-- mapping aichat to the windows assistant key
hl.bind("SUPER + SHIFT + code:201", hl.dsp.workspace.toggle_special("aichat"))
