-- Environment variables
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

hl.env("GDK_SCALE", "1")

-- Cursor size
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- Cursor theme
hl.env("XCURSOR_THEME", "Adwaita")
hl.env("HYPRCURSOR_THEME", "Adwaita")

-- Force all apps to use Wayland
hl.env("GDK_BACKEND", "wayland")
hl.env("QT_QPA_PLATFORM", "wayland")
hl.env("QT_STYLE_OVERRIDE", "kvantum")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")
hl.env("OZONE_PLATFORM", "wayland")

-- Make Chromium use XCompose and all Wayland
hl.env("CHROMIUM_FLAGS", "--enable-features=UseOzonePlatform --ozone-platform=wayland --gtk-version=4")

-- Make .desktop files available for wofi
local function appendDir(list, dir)
    if dir and dir ~= "" then
        list[#list + 1] = dir
    end
end

local home = os.getenv("HOME")
local dataDirs = {}
appendDir(dataDirs, os.getenv("XDG_DATA_DIRS"))
appendDir(dataDirs, home and (home .. "/.nix-profile/share"))
appendDir(dataDirs, "/nix/var/nix/profiles/default/share")

hl.env("XDG_DATA_DIRS", table.concat(dataDirs, ":"))

-- Use XCompose file
hl.env("XCOMPOSEFILE", "~/.XCompose")
hl.env("EDITOR", "nvim")

-- GTK theme
hl.env("GTK_THEME", "Adwaita:dark")

hl.config({
    xwayland = {
        force_zero_scaling = true,
    },

    -- Don't show update on first launch
    ecosystem = {
        no_update_news = true,
    },
})
