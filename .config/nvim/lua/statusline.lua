--[[https://nuxsh.is-a.dev/blog/custom-nvim-statusline.html]]--

local fn = vim.fn
local api = vim.api

local modes = {
  ["n"] = "NORMAL",
  ["no"] = "NORMAL",
  ["i"] = "INSERT",
  ["ic"] = "INSERT",
  ["v"] = "VISUAL",
  [""] = "VISUAL BLOCK",
  ["V"] = "VISUAL LINE",
  ["s"] = "SELECT",
  ["S"] = "SELECT LINE",
  ["R"] = "REPLACE",
  ["c"] = "COMMAND",
  ["t"] = "TERMINAL",
}

local function mode()
  local current_mode = api.nvim_get_mode().mode
  return string.format(" %s ", modes[current_mode]):upper()
end

local function update_mode_colors()
  local current_mode = api.nvim_get_mode().mode
  local mode_color = "%#StatusLineAccent#"
  if current_mode == "n" then
      mode_color = "%#StatuslineAccent#"
  elseif current_mode == "i" then
      mode_color = "%#StatuslineInsertAccent#"
  elseif current_mode == "v" or current_mode == "V" or current_mode == "" then
      mode_color = "%#StatuslineVisualAccent#"
  elseif current_mode == "s" then
      mode_color = "%#StatuslineSelect#"
  elseif current_mode == "R" then
      mode_color = "%#StatuslineReplaceAccent#"
  elseif current_mode == "c" then
      mode_color = "%#StatuslineCmdLineAccent#"
  elseif current_mode == "t" then
      mode_color = "%#StatuslineTerminalAccent#"
  end
  return mode_color
end

local function filepath()
  local fpath = fn.fnamemodify(fn.expand "%", ":~:.:h")
  if fpath == "" or fpath == "." then
      return " "
  end
  return string.format(" %%<%s/", fpath)
end

local function filename()
  local fname = fn.expand "%:t"
  if fname == "" then
      return ""
  end
  return fname .. " "
end

local function filetype()
  return string.format(" %s", vim.bo.filetype):upper()
end

local function lineinfo()
  if vim.bo.filetype == "alpha" then
    return ""
  end
  return " %P %l:%c "
end

Statusline = {}

Statusline.active = function()
  return table.concat {
    "%#Statusline#",
    update_mode_colors(),
    mode(),
    "%#StatusLine# ",
    filepath(),
    filename(),
    "%m%=%#StatusLineExtra#",
    "%#StatusLineExtra#",
    filetype(),
    lineinfo(),
  }
end

function Statusline.inactive()
  return "%#StatusLineNC#%F"
end

api.nvim_exec([[
  augroup Statusline
  au!
  au WinEnter,BufEnter * set nu rnu
  au WinLeave,BufLeave * set nonu nornu
  au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline.active()
  au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline.inactive()
  au WinEnter,BufEnter,FileType netrw setlocal statusline=%!v:lua.Statusline.inactive()
  augroup END
]], false)
