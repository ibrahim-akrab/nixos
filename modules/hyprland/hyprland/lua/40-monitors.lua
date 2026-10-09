hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto-up",
    scale    = "auto",
})

-- Workspace assignments
-- Workspaces 1-5 for built-in displays
for i = 1, 5 do
    hl.workspace_rule({ workspace = tostring(i), monitor = "eDP-1" })
end

-- Workspaces 6-10 for external monitors
-- These will bind to whichever external monitor is connected
for i = 6, 10 do
    hl.workspace_rule({ workspace = tostring(i), monitor = "HDMI-A-1" })
end
