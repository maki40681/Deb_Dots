---- MONITORS ----
hl.monitor({
    output   = "eDP-1",
    mode     = "1920x1080@60",
    position = "0x0",
    scale    = "1",
})

---- MY PROGRAMS ----
local terminal    = "ghostty"
local fileManager = "thunar"
local browser	  = "helium-browser"
local menu        = "bemenu-run -H 20 --ch 24 --fn 'JetBrainsMono Nerd Font [10]' -p 'debian  ' --tb '#2d2d2d' --tf '#f2777a' --fb '#2d2d2d' --ff '#6699cc' --nb '#2d2d2d' --nf '#747369' --hb '#2d2d2d' --hf '#d3d0c8' --ab '#2d2d2d' --af '#747369'"

---- AUTOSTART ----
hl.on("hyprland.start", function () 
  hl.exec_cmd("qs")
  hl.exec_cmd("hs")
  hl.exec_cmd("blueman-applet")
  hl.exec_cmd("swaybg -c 2d2d2d")
  hl.exec_cmd("hyprsunset -t 4500")
  hl.exec_cmd("/usr/lib/hyprpolkitagent/hyprpolkitagent")
end)

---- ENVIRONMENT VARIABLES ----
hl.env("XCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "Yaru")
hl.env("HYPRCURSOR_SIZE", "24")

hl.env("EDITOR", "nvim")

hl.env("GTK_THEME", "Adwaita-dark")
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")

hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
----- PERMISSIONS -----
-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")

---- LOOK AND FEEL ----
hl.config({

    general = {
        gaps_in  = 3,
        gaps_out = 6,
        border_size = 3,

        col = {
            active_border   = "rgb(cc99cc)",
            inactive_border = "rgb(747369)",
        },

        layout = "master",
	resize_corner = 3,
    },

    decoration = {
        shadow = { enabled = false },
        blur = { enabled = false },
    },

    animations = {
        enabled = false,
    },

    group = {
	col = {
	    border_active = "rgb(2d2d2d)",
	    border_inactive = "rgb(2d2d2d)",
	},
	groupbar = {
	    font_size = 14,
	    indicator_gap = 2,
	    col = {
		active = "rgb(cc99cc)",
		inactive = "rgb(747369)",
	    }
	},
    },

})

---- INPUT ----
hl.config({
    input = {
	repeat_rate = 40,
	repeat_delay = 300
    }
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})


---- KEYBINDINGS ----
local mainMod = "SUPER" -- Sets "Windows" key as main modifier

hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + CONTROL + RETURN", hl.dsp.exec_cmd("say tmux && ghostty -e tmux attach -t TMUX"))

hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("hypridle"))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.exec_cmd("hyprlock & hypridle"))
local closeWindowBind = hl.bind(mainMod .. " + W", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exec_cmd("say logout"))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + grave", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + grave", hl.dsp.window.move({ workspace = "special:magic" }))

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e+1" }))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind(mainMod .. " + up",	hl.dsp.exec_cmd("ddcutil setvcp 10 + 10"),                  { locked = true, repeating = true })
hl.bind(mainMod .. " + down",	hl.dsp.exec_cmd("ddcutil setvcp 10 - 10"),                  { locked = true, repeating = true })

hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

hl.bind("Print", hl.dsp.exec_cmd("grim -g \"$(slurp -d)\" - | wl-copy"))
hl.bind(mainMod .. " + Print", hl.dsp.exec_cmd("grim"))

---- WINDOW MX ----
hl.config({
    master = {
        new_status = "master",
	new_on_top = true,
	drop_at_cursor = true,
    },
})

hl.config({
    scrolling = {
	column_width = 0.95,
	focus_fit_method = 0
    }
    })

hl.bind(mainMod .. " + K", hl.dsp.layout("cycleprev"))
hl.bind(mainMod .. " + J", hl.dsp.window.cycle_next({ next = true, tiled = true, floating = false }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.cycle_next({ next = true, tiled = false, floating = true }))

hl.bind(mainMod .. " + I", hl.dsp.layout("addmaster"))
hl.bind(mainMod .. " + D", hl.dsp.layout("removemaster"))
hl.bind(mainMod .. " + SHIFT + RETURN", hl.dsp.layout("swapwithmaster master"))

hl.bind(mainMod .. " + L", hl.dsp.layout("mfact +0.05"))
hl.bind(mainMod .. " + H", hl.dsp.layout("mfact -0.05"))

hl.bind(mainMod .. " + c", hl.dsp.window.center())
hl.bind(mainMod .. " + S", hl.dsp.window.float({ action = "toggle" }))

hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("qs ipc call bar toggle"))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind(mainMod .. " + CONTROL + F", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen_state({ internal = "0", client = "2", action = "toggle" }))

hl.bind(mainMod .. " + T", hl.dsp.group.toggle())
hl.bind(mainMod .. " + right", hl.dsp.group.next())
hl.bind(mainMod .. " + left", hl.dsp.group.prev())
hl.bind(mainMod .. " + SHIFT + left", hl.dsp.window.move({ into_or_create_group = "l" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ out_of_group = "l" }))

hl.bind(mainMod .. " + TAB", hl.dsp.focus({ workspace = "previous" }))

-- shift focus b/w tiled & floating
local function toggle_floating_tiled()
    local active = hl.get_active_window()

    if active and active.floating then
        hl.dispatch(hl.dsp.focus({ window = "tiled" }))
    else
        hl.dispatch(hl.dsp.focus({ window = "floating" }))
    end
end
hl.bind(mainMod .. "+ V", toggle_floating_tiled)

-- smort gaps
hl.workspace_rule({ workspace = "w[tv1]s[false]", gaps_out = 0, gaps_in = 0 })
hl.workspace_rule({ workspace = "f[1]s[false]", gaps_out = 0, gaps_in = 0 })
hl.window_rule({ match = { float = false, workspace = "w[tv1]s[false]" }, border_size = 0 })
hl.window_rule({ match = { float = false, workspace = "w[tv1]s[false]" }, rounding = 0 })
hl.window_rule({ match = { float = false, workspace = "f[1]s[false]" }, border_size = 0 })
hl.window_rule({ match = { float = false, workspace = "f[1]s[false]" }, rounding = 0 })

-- zoom
local MAX_ZOOM = 3
local MIN_ZOOM = 1
local ZOOM_TOGGLE_FACTOR = 1.5

---@param offset number
---@return nil
local function zoom(offset)
    local current = hl.get_config("cursor.zoom_factor")
    if offset ~= nil then
        current = current + offset
    elseif current ~= MIN_ZOOM then
        current = MIN_ZOOM
    else
        current = ZOOM_TOGGLE_FACTOR
    end
    current = math.max(MIN_ZOOM, math.min(MAX_ZOOM, current))
    hl.config({ cursor = { zoom_factor = current } })
end

hl.bind(mainMod .. " + X", function()
    zoom(0.5)
end)
hl.bind(mainMod .. " + Z", function()
    zoom(-0.5)
end)

---- WINDOWS AND WORKSPACES ----
local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
    -- Fix some dragging issues with XWayland
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

-- Hyprland-run windowrule
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})

---- WINDOW RULES ----
hl.window_rule({ match = { class = "helium" }, workspace = 2 })
hl.window_rule({ match = { class = fileManager }, workspace = 3 })
hl.window_rule({ match = { class = "org.pwmt.zathura" }, workspace = 3 })
hl.window_rule({ match = { class = "mpv" }, workspace = 4 })
hl.window_rule({ match = { class = "vesktop" }, workspace = 5 })
hl.window_rule({ match = { class = "org.telegram.desktop" }, workspace = 6 })

hl.window_rule({ match = { class = "chrome-nngceckbapebfimnlniiiahkandclblb-Default" }, float = true })
hl.window_rule({ match = { class = "xdg-desktop-portal-gtk" }, size = "1000 800", center = true })

hl.bind(mainMod .. " + Y", function ()
    local layouts     = { "master", "scrolling" }
    local workspace   = hl.get_active_workspace()
	if hl.get_active_special_workspace() then
		workspace = hl.get_active_special_workspace()
	end

    local next_layout = "scrolling"

    if not workspace then
        return
    end

    for i = 1, #layouts do
        if layouts[i] == workspace.tiled_layout then
            local next_layout_idx = (i % #layouts) + 1
            next_layout = layouts[next_layout_idx]
            break
        end
    end

	if workspace.special then
		hl.workspace_rule({ workspace = tostring(workspace.name), layout = next_layout })
	else
		hl.workspace_rule({ workspace = tostring(workspace.id), layout = next_layout })
	end
end)
