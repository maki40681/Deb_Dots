local c = {
    bg      = 0xff2d2d2d,
    bg2     = 0xff393939,
    sel     = 0xff515151,

    fg      = 0xffd3d0c8,
    dim     = 0xff747369,

    red     = 0xfff2777a,
    green   = 0xff99cc99,
    yellow  = 0xffffcc66,
    blue    = 0xff6699cc,
    magenta = 0xffcc99cc,
    cyan    = 0xff66cccc,
    orange  = 0xfff99157,

    overlay = 0xcc2d2d2d,
    shadow  = 0xdd000000,
}

--------------------------------------------------------------------------------
-- General config
--------------------------------------------------------------------------------
swayimg.set_mode("viewer")                -- mode at startup
swayimg.enable_antialiasing(true)         -- anti-aliasing
swayimg.enable_decoration(false)          -- window title/buttons/borders
swayimg.enable_overlay(false)             -- window overlay mode
swayimg.enable_exif_orientation(true)     -- image orientation by EXIF
swayimg.set_dnd_button("MouseRight")      -- drag-and-drop mouse button

-- Format specific parameters
swayimg.set_format_params('raw', { camera_wb = true }) -- use camera white balance

--------------------------------------------------------------------------------
-- Image list configuration
--------------------------------------------------------------------------------
swayimg.imagelist.set_order("numeric")    -- list order
swayimg.imagelist.enable_reverse(false)   -- reverse order
swayimg.imagelist.enable_recursive(false) -- recursive directory reading
swayimg.imagelist.enable_adjacent(false)  -- add adjacent files from same dir
swayimg.imagelist.enable_fsmon(true)      -- enable file system monitoring

--------------------------------------------------------------------------------
-- Text overlay configuration
--------------------------------------------------------------------------------
swayimg.text.set_font("JetBrainsMono Nerd Font")        -- font name
swayimg.text.set_size(20)                 -- font size in pixels
swayimg.text.set_spacing(0)               -- line spacing
swayimg.text.set_padding(10)              -- padding from window edge
swayimg.text.set_foreground(c.fg)   -- foreground text color
swayimg.text.set_background(c.bg)   -- text background color
swayimg.text.set_shadow(0x00000000)       -- text shadow color
swayimg.text.set_timeout(5)               -- layer hide timeout
swayimg.text.set_status_timeout(3)        -- status message hide timeout

--------------------------------------------------------------------------------
-- Image viewer mode
--------------------------------------------------------------------------------
swayimg.viewer.set_default_scale("width")      -- default image scale
swayimg.viewer.set_default_position("center")    -- default image position
swayimg.viewer.set_drag_button("MouseLeft")      -- mouse button to drag image
swayimg.viewer.set_window_background(c.bg) -- window background color
swayimg.viewer.set_image_chessboard(20, 0xff333333, 0xff4c4c4c) -- chessboard
swayimg.viewer.enable_centering(true)            -- enable automatic centering
swayimg.viewer.enable_loop(true)                 -- enable image list loop mode
swayimg.viewer.limit_preload(1)                  -- number of images to preload
swayimg.viewer.limit_history(1)                  -- number of the history cache
swayimg.viewer.set_mark_color(c.red)        -- mark icon color
swayimg.viewer.set_pinch_factor(1.0)             -- pinch gesture factor
swayimg.viewer.set_text("topleft", {             -- top left text block scheme
  "File:\t{name}",
  "Format:\t{format}",
  "File size:\t{sizehr}",
  "File time:\t{time}",
  "EXIF date:\t{meta.Exif.Photo.DateTimeOriginal}",
  "EXIF camera:\t{meta.Exif.Image.Model}"
})
swayimg.viewer.set_text("topright", {            -- top right text block scheme
  "Image:\t{list.index} of {list.total}",
  "Scale:\t{scale}",
  "Size:\t{frame.width}x{frame.height}"
})
swayimg.viewer.set_text("bottomleft", {})

-- exit from application
swayimg.viewer.on_key("q", function()
  swayimg.exit()
end)

-- switch to gallery mode
swayimg.viewer.on_key("Return", function()
  swayimg.set_mode("gallery")
end)

-- show/hide text overlay
swayimg.viewer.on_key("i", function()
  if swayimg.text.visible() then
    swayimg.text.hide()
  else
    swayimg.text.show()
  end
end)

-- mark/unmark current image
swayimg.viewer.on_key("m", function()
  swayimg.viewer.mark_image()
end)

-- remove current image from the image list
swayimg.viewer.on_key("Delete", function()
  local img = swayimg.viewer.get_image()
  if img then
    swayimg.imagelist.remove(img.path)
  end
end)

-- toggle fullscreen
swayimg.viewer.on_key("f", function()
  swayimg.set_fullscreen()
end)

-- rotate image
swayimg.viewer.on_key("]", function()
  swayimg.viewer.rotate(90)
end)
swayimg.viewer.on_key("[", function()
  swayimg.viewer.rotate(270)
end)

-- flip image
swayimg.viewer.on_key("t", function()
  swayimg.viewer.flip_vertical()
end)
swayimg.viewer.on_key("Shift+t", function()
  swayimg.viewer.flip_horizontal()
end)

-- zoom in/out
swayimg.viewer.on_key("equal", function()
  local scale = swayimg.viewer.get_scale()
  swayimg.viewer.set_abs_scale(scale + scale / 10)
end)
swayimg.viewer.on_key("minus", function()
  local scale = swayimg.viewer.get_scale()
  swayimg.viewer.set_abs_scale(scale - scale / 10)
end)

-- reset scale/position
swayimg.viewer.on_key("backspace", function()
  swayimg.viewer.reset()
end)

-- move image across the window
swayimg.viewer.on_key("left", function()
  local pos = swayimg.viewer.get_position()
  swayimg.viewer.set_abs_position(pos.x + 10, pos.y)
end)
swayimg.viewer.on_key("right", function()
  local pos = swayimg.viewer.get_position()
  swayimg.viewer.set_abs_position(pos.x - 10, pos.y)
end)
swayimg.viewer.on_key("up", function()
  local pos = swayimg.viewer.get_position()
  swayimg.viewer.set_abs_position(pos.x, pos.y + 10)
end)
swayimg.viewer.on_key("down", function()
  local pos = swayimg.viewer.get_position()
  swayimg.viewer.set_abs_position(pos.x, pos.y - 10)
end)

-- open next/previous image
swayimg.viewer.on_key("k", function()
  swayimg.viewer.switch_image("next")
end)
swayimg.viewer.on_key("j", function()
  swayimg.viewer.switch_image("prev")
end)

-- move image across the window (mouse/touchpad)
swayimg.viewer.on_mouse("ScrollUp", function()
  local pos = swayimg.viewer.get_position()
  swayimg.viewer.set_abs_position(pos.x, pos.y - 10)
end)
swayimg.viewer.on_mouse("ScrollDown", function()
  local pos = swayimg.viewer.get_position()
  swayimg.viewer.set_abs_position(pos.x, pos.y + 10)
end)
swayimg.viewer.on_mouse("ScrollLeft", function()
  local pos = swayimg.viewer.get_position()
  swayimg.viewer.set_abs_position(pos.x - 10, pos.y)
end)
swayimg.viewer.on_mouse("ScrollRight", function()
  local pos = swayimg.viewer.get_position()
  swayimg.viewer.set_abs_position(pos.x + 10, pos.y)
end)

-- zoom in/out (mouse/touchpad)
swayimg.viewer.on_mouse("Ctrl+ScrollUp", function()
  local mouse = swayimg.get_mouse_pos()
  local scale = swayimg.viewer.get_scale()
  swayimg.viewer.set_abs_scale(scale + scale / 10, mouse.x, mouse.y)
end)
swayimg.viewer.on_mouse("Ctrl+ScrollDown", function()
  local mouse = swayimg.get_mouse_pos()
  local scale = swayimg.viewer.get_scale()
  swayimg.viewer.set_abs_scale(scale - scale / 10, mouse.x, mouse.y)
end)

--------------------------------------------------------------------------------
-- Gallery mode
--------------------------------------------------------------------------------
swayimg.gallery.set_aspect("fill")                  -- thumbnail aspect ratio
swayimg.gallery.set_thumb_size(200)                 -- thumbnail size in pixels
swayimg.gallery.set_padding_size(5)                 -- padding between thumbnails
swayimg.gallery.set_border_size(5)                  -- border size for selected thumbnail
swayimg.gallery.set_border_color(c.yellow)        -- border color for selected thumbnail
swayimg.gallery.set_mark_color(c.red)        -- border color for selected thumbnail
swayimg.gallery.set_selected_scale(1.15)            -- scale for selected thumbnail
swayimg.gallery.set_selected_color(c.bg)      -- background color for selected thumbnail
swayimg.gallery.set_unselected_color(c.bg)    -- background color for unselected thumbnail
swayimg.gallery.set_window_color(c.bg)        -- window background color
swayimg.gallery.set_pinch_factor(100.0)             -- pinch gesture factor
swayimg.gallery.enable_hover(true)                  -- enable mouse following
swayimg.gallery.limit_cache(100)                    -- number of thumbnails stored in memory
swayimg.gallery.enable_embedded_thumb(true)         -- use embedded thumbnails
swayimg.gallery.enable_preload(false)               -- preloading invisible thumbnails
swayimg.gallery.enable_pstore(false)                -- enable persistent storage for thumbnails
swayimg.gallery.set_text("topleft", {               -- top left text block scheme
  "File:\t{name}"
})
swayimg.gallery.set_text("topright", {              -- top right text block scheme
  "{list.index} of {list.total}"
})

-- exit from application
swayimg.gallery.on_key("q", function()
  swayimg.exit()
end)

-- switch to viewer mode
swayimg.gallery.on_key("Return", function()
  swayimg.set_mode("viewer")
end)

-- show/hide text overlay
swayimg.gallery.on_key("i", function()
  if swayimg.text.visible() then
    swayimg.text.hide()
  else
    swayimg.text.show()
  end
end)

-- mark/unmark current image
swayimg.gallery.on_key("m", function()
  swayimg.gallery.mark_image()
end)

-- remove current image from the image list
swayimg.gallery.on_key("Delete", function()
  local img = swayimg.gallery.get_image()
  if img then
    swayimg.imagelist.remove(img.path)
  end
end)

-- toggle fullscreen
swayimg.gallery.on_key("f", function()
  swayimg.set_fullscreen()
end)

-- thumbnail zoom in/out
swayimg.gallery.on_key("equal", function()
  local size = swayimg.gallery.get_thumb_size()
  swayimg.gallery.set_thumb_size(size + 10)
end)
swayimg.gallery.on_key("minus", function()
  local size = swayimg.gallery.get_thumb_size()
  swayimg.gallery.set_thumb_size(size - 10)
end)

-- select another thumbnail
swayimg.gallery.on_key("home", function()
  swayimg.gallery.select("first")
end)
swayimg.gallery.on_key("end", function()
  swayimg.gallery.select("last")
end)
swayimg.gallery.on_key("k", function()
  swayimg.gallery.switch_image("up")
end)
swayimg.gallery.on_key("j", function()
  swayimg.gallery.switch_image("down")
end)
swayimg.gallery.on_key("h", function()
  swayimg.gallery.switch_image("left")
end)
swayimg.gallery.on_key("l", function()
  swayimg.gallery.switch_image("right")
end)

-- select another thumbnail (mouse/touchpad)
swayimg.gallery.on_mouse("ScrollUp", function()
  swayimg.gallery.switch_image("right")
end)
swayimg.gallery.on_mouse("ScrollDown", function()
  swayimg.gallery.switch_image("left")
end)

-- thumbnail zoom in/out (mouse/touchpad)
swayimg.gallery.on_mouse("Ctrl+ScrollUp", function()
  local size = swayimg.gallery.get_thumb_size()
  swayimg.gallery.set_thumb_size(size + 10)
end)
swayimg.gallery.on_mouse("Ctrl+ScrollDown", function()
  local size = swayimg.gallery.get_thumb_size()
  swayimg.gallery.set_thumb_size(size - 10)
end)


swayimg.on_window_resize(function()
  swayimg.viewer.set_fix_scale("optimal")
end)

swayimg.gallery.on_key("Ctrl-p", function()
  local entries = swayimg.imagelist.get()
  for _, entry in ipairs(entries) do
    if entry.mark then
        print(entry.path)
    end
  end
end)
