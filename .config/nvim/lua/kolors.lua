local bg0 = "#2d2d2d"
local bg8 = "#747369"
local fg7 = "#d3d0c8"
local fg15 = "#f2f0ec"
local red = "#f2777a"
local green = "#99cc99"
local yellow = "#ffcc66"
local blue = "#6699cc"
local purple = "#cc99cc"
local cyan = "#66cccc"
local trans = "#4d4d4d"

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })

vim.api.nvim_set_hl(0, "StatusLine", { bg = bg8, fg = fg15 })
vim.api.nvim_set_hl(0, "StatusLineNC", { bg = trans, fg = fg7 })
vim.api.nvim_set_hl(0, "StatusLineExtra", { bg = fg15, fg = bg0  })
vim.api.nvim_set_hl(0, "StatusLineSelect", { bg = red, fg = bg0 })
vim.api.nvim_set_hl(0, "StatusLineAccent", { bg = blue, fg = bg0 })
vim.api.nvim_set_hl(0, "StatusLineVisualAccent", { bg = purple, fg = bg0 })
vim.api.nvim_set_hl(0, "StatusLineInsertAccent", { bg = green, fg = bg0 })
vim.api.nvim_set_hl(0, "StatusLineReplaceAccent", { bg = red, fg = bg0 })
vim.api.nvim_set_hl(0, "StatusLineTerminalAccent", { bg = cyan, fg = bg0 })

vim.api.nvim_set_hl(0, "Title", { fg = cyan })
vim.api.nvim_set_hl(0, "Visual", { bg = trans })
vim.api.nvim_set_hl(0, "NonText", { fg = bg8 })
vim.api.nvim_set_hl(0, "Question", { fg = yellow, italic = true })
vim.api.nvim_set_hl(0, "ErrorMsg", { bg = red, fg = bg0 })
vim.api.nvim_set_hl(0, "VertSplit", { bg = trans, fg = trans })
vim.api.nvim_set_hl(0, "Directory", { fg = cyan })
vim.api.nvim_set_hl(0, "MatchParen", { bg = red, fg = bg0 })

vim.api.nvim_set_hl(0, "Search", { bg = red, fg = bg0 })
vim.api.nvim_set_hl(0, "IncSearch", { bg = red, fg = bg0 })
vim.api.nvim_set_hl(0, "CurSearch", { bg = red, fg = bg0 })

vim.api.nvim_set_hl(0, "LineNr", { fg = bg8 })
vim.api.nvim_set_hl(0, "CursorLine", { bg = trans })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = fg15, bold = true })


vim.api.nvim_set_hl(0, "Comment", { fg = bg8 })

vim.api.nvim_set_hl(0, "Identifier", { fg = cyan })
vim.api.nvim_set_hl(0, "Function", { fg = cyan })

vim.api.nvim_set_hl(0, "Statement", { fg = yellow })
vim.api.nvim_set_hl(0, "Conditional", { fg = yellow })
vim.api.nvim_set_hl(0, "Repeat", { fg = yellow })
vim.api.nvim_set_hl(0, "Label", { fg = yellow })
vim.api.nvim_set_hl(0, "Operator", { fg = yellow })
vim.api.nvim_set_hl(0, "Keyword", { fg = yellow })
vim.api.nvim_set_hl(0, "Exception", { fg = yellow })

vim.api.nvim_set_hl(0, "Preproc", { fg = purple })
vim.api.nvim_set_hl(0, "Include", { fg = purple })
vim.api.nvim_set_hl(0, "Define", { fg = purple })
vim.api.nvim_set_hl(0, "Macro", { fg = purple })
vim.api.nvim_set_hl(0, "PreCondit", { fg = purple })

vim.api.nvim_set_hl(0, "Type", { fg = green })
vim.api.nvim_set_hl(0, "StorageClass", { fg = green })
vim.api.nvim_set_hl(0, "Structure", { fg = green })
vim.api.nvim_set_hl(0, "TypeDef", { fg = green })

vim.api.nvim_set_hl(0, "Special", { fg = blue })
vim.api.nvim_set_hl(0, "SpecialChar", { fg = blue })
vim.api.nvim_set_hl(0, "Tag", { fg = blue })
vim.api.nvim_set_hl(0, "Delimiter", { fg = blue })
vim.api.nvim_set_hl(0, "SpecialComment", { fg = blue })
vim.api.nvim_set_hl(0, "Debug", { fg = blue })

vim.api.nvim_set_hl(0, "Pmenu", { bg = bg8, fg = fg15 })
vim.api.nvim_set_hl(0, "PmenuSel", { bg = purple, fg = bg0 })

vim.api.nvim_set_hl(0, "TabLine", { fg = bg8, italic = true })
vim.api.nvim_set_hl(0, "TabLineFill", { })
vim.api.nvim_set_hl(0, "TabLineSel", { fg = purple, bold = true })
