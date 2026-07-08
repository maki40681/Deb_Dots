--[[https://vonheikemen.github.io/devlog/tools/configuring-neovim-using-lua/]]--

require('statusline')
require('kolors')
--require("config.lazy")

--[[ OPTS ]]--
local set = vim.opt

set.number = true
set.cursorline = true
set.relativenumber = true

set.wrap = true
set.linebreak = true
set.showbreak = "+++"

set.hlsearch = true
set.showmatch = true
set.incsearch = true
set.smartcase = true
set.ignorecase = true

set.shiftwidth = 4
set.softtabstop = 4
set.backspace = "indent,eol,start"

set.autoread = true
set.autowrite = true

set.splitbelow = true
set.splitright = true

set.mouse = "a"
set.showcmd = true
set.wildmenu = true
set.swapfile = false
set.termguicolors = true
set.clipboard = "unnamedplus"
set.selectmode = set.selectmode + 'mouse'
set.formatoptions:remove({ "r", "o", "c" })
set.guifont = "FantasqueSansMono Nerd Font:h11:cDEFAULT"

--[[ VARS ]]--
vim.g['netrw_banner'] = 0
vim.g['netrw_winsize'] = 10
vim.g['netrw_liststyle'] = 1
vim.g['netrw_browse_split'] = 4

--[[ BINDS ]]--
local setkey = vim.api.nvim_set_keymap

setkey('n', 'gn', ':tabN<CR>', {noremap = true})
setkey('n', 'gp', ':tabp<CR>', {noremap = true})
setkey('n', 'gt', ':tabnew<CR>', {noremap = true})
setkey('n', 'gd', ':tabc<CR>', {noremap = true})

setkey('n', '<A-q>', ':q<CR>', {noremap = true})
setkey('n', '<A-x>', ':w<CR>', {noremap = true})

setkey('n', '<A-h>', ':sp<CR>', {noremap = true})
setkey('n', '<A-v>', ':vsp<CR>', {noremap = true})
setkey('n', '<A-tab>', '<C-w>w', {noremap = true})

setkey('t', '<Esc>', '<C-\\><C-n>', {noremap = true})

setkey('n', '<A-e>', ':Lexplore<CR>', {noremap = true})

vim.cmd [[

autocmd TabNew * call feedkeys(":Lexplore\<CR>", 'n')
autocmd BufWritePost $HOME/.local/src/dwm/dwm.c !cd $HOME/.local/src/dwm; make install && xsetroot -name fsignal:2
autocmd BufWritePost $HOME/.local/src/dwm/config.h !cd $HOME/.local/src/dwm; make install && xsetroot -name fsignal:2
autocmd BufWritePost $HOME/PiroGramming/main.c !cd $HOME/PiroGramming/; gcc main.c && ./a.out

]]
