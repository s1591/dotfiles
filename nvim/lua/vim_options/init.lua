vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.o.hlsearch = true
vim.wo.relativenumber = true
vim.o.mouse = 'a'
vim.o.clipboard = 'unnamedplus'
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.wo.signcolumn = 'yes'
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.completeopt = 'menuone,noselect'
vim.o.termguicolors = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
-- neovide
vim.o.guifont = "jetBrainsMono Nerd Font:h16"
vim.g.neovide_cursor_vfx_mode = "railgun" -- pixiedust,sonicboom,ripple,wireframe,torpedo,railgun
vim.g.neovide_cursor_vfx_opacity = "500.0"
vim.g.neovide_cursor_vfx_particle_lifetime = 1.5
-- end neovide
vim.cmd('colorscheme catppuccin')
-- re-open at last position
vim.cmd [[ au BufReadPost * if line("'\"") >= 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif ]]
