--https://github.com/imsi32/yatline.yazi/tree/main
require("yatline"):setup({

section_separator = { open = "", close = "" },
part_separator = { open = "", close = "" },
inverse_separator = { open = "", close = "" },

padding = { inner = 1, outer = 1 },

style_a = {
    fg = "black",
    bg_mode = {
        normal = "blue",
        select = "red",
        un_set = "magenta"
    }
},
style_b = { bg = "brightblack", fg = "brightwhite" },
style_c = { bg = "reset", fg = "brightwhite" },

show_background = false,

--display_header_line = false,
--display_status_line = false,

status_line = {
    left = {
	section_a = {
    		{ type = "string", name = "tab_mode" },
    	},
    	section_b = {
    		{ type = "string", name = "hovered_path" },
    	},
    	section_c = {
    		{ type = "coloreds", name = "count" },
    	},
    },
    right = {
    	section_a = {},
    	section_b = {},
    	section_c = {},
    },
},

header_line = {
    left = {
    	section_a = {},
    	section_b = {},
    	section_c = {},
    },
    right = {
	section_a = {
        },
        section_b = {
    	   { type = "line", name = "tabs", params = {"left"} },
	   { type = "string", name = "cursor_position" },
        },
        section_c = {
	   { type = "string", name = "hovered_file_extension", params = { true } },
    	   { type = "string", name = "hovered_size" },
	   { type = "string", custom = false, name = "hovered_mtime"},
    	   { type = "coloreds", name = "permissions" },
        },
    },
},

component_positions = { "status", "header", "tab"},

})

function Yatline.string.get:hovered_mtime()
	local hovered = cx.active.current.hovered
	if not hovered or not hovered.cha.mtime then
		return ""
	end

	return os.date("%Y-%m-%d %H:%M", hovered.cha.mtime // 1)
end
