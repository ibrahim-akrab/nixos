-- https://wiki.hypr.land/Configuring/Variables/#input
hl.config({
    input = {
        kb_layout = "us",
        -- kb_variant = "",
        -- kb_model = "",
        -- kb_options = "compose:caps",
        -- kb_rules = "",

        follow_mouse = 1,

        sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = true,
            drag_lock = 0,
        },
    },
})

-- https://wiki.hypr.land/Configuring/Variables/#gestures
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
hl.gesture({ fingers = 3, direction = "pinch", scale = 1.5, action = "fullscreen" })
