-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- Rules are applied in order: broad rules first, specific overrides after.

hl.window_rule({
    -- Ignore maximize requests from all apps.
    name  = "suppress-maximize",
    match = { class = ".*" },

    suppress_event = "maximize",
})

-- Force chromium into a tile to deal with --app bug
hl.window_rule({
    name  = "tile-chromium",
    match = { class = "^(chromium)$" },

    tile = true,
})

-- Settings management
hl.window_rule({
    name  = "float-settings-managers",
    match = { class = "^(org.pulseaudio.pavucontrol|.blueman-manager-wrapped)$" },

    float = true,
})

-- Float Steam, fullscreen RetroArch
hl.window_rule({
    name  = "float-steam",
    match = { class = "^(steam)$" },

    float = true,
})

hl.window_rule({
    name  = "fullscreen-retroarch",
    match = { class = "^(com.libretro.RetroArch)$" },

    fullscreen = true,
})

-- Just a dash of transparency
hl.window_rule({
    name  = "opacity-default",
    match = { class = ".*" },

    opacity = "0.97 0.9",
})

-- Normal chrome Youtube tabs
hl.window_rule({
    name  = "opacity-chrome-youtube",
    match = {
        class = "^(chromium|google-chrome|google-chrome-unstable)$",
        title = ".*Youtube.*",
    },

    opacity = "1 1",
})

hl.window_rule({
    name  = "opacity-chrome",
    match = { class = "^(chromium|google-chrome|google-chrome-unstable)" },

    opacity = "1 0.97",
})

-- Web apps
hl.window_rule({
    name  = "opacity-web-apps",
    match = { initial_class = "^(chrome-.*-Default)$" },

    opacity = "0.97 0.9",
})

-- Youtube web app
hl.window_rule({
    name  = "opacity-youtube-web-app",
    match = { initial_class = "^(chrome-youtube.*-Default)$" },

    opacity = "1 1",
})

hl.window_rule({
    name  = "opacity-media-apps",
    match = { class = "^(zoom|vlc|org.kde.kdenlive|com.obsproject.Studio)$" },

    opacity = "1 1",
})

hl.window_rule({
    name  = "opacity-games",
    match = { class = "^(com.libretro.RetroArch|steam)$" },

    opacity = "1 1",
})

-- Fix some dragging issues with XWayland
hl.window_rule({
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

-- Float in the middle for clipse clipboard manager
hl.window_rule({
    name  = "clipse",
    match = { class = "(clipse)" },

    float         = true,
    size          = "622 652",
    stay_focused  = true,
})

-- Proper background blur for wofi and waybar
hl.layer_rule({
    name  = "blur-wofi",
    match = { namespace = "wofi" },

    blur = true,
})

hl.layer_rule({
    name  = "blur-waybar",
    match = { namespace = "waybar" },

    blur = true,
})
