require "nvchad.options"

vim.o.termguicolors = true
vim.o.hlsearch = true
vim.opt.incsearch = true
vim.wo.relativenumber = true
vim.o.mouse = "a"
vim.o.clipboard = "unnamedplus"
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.wo.signcolumn = "yes"
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.completeopt = "menuone,noselect"
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
-- neovide
vim.o.guifont = "jetBrainsMono Nerd Font:h16"
vim.g.neovide_cursor_vfx_mode = "railgun" -- pixiedust,sonicboom,ripple,wireframe,torpedo,railgun
vim.g.neovide_cursor_vfx_opacity = "500.0"
vim.g.neovide_cursor_vfx_particle_lifetime = 1.5
-- end neovide
-- re-open at last position
vim.cmd [[ au BufReadPost * if line("'\"") >= 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif ]]
