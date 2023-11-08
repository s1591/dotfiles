vim.o.guifont = "jetBrainsMono Nerd Font:h8"
vim.g.neovide_cursor_vfx_mode = "railgun" -- pixiedust,sonicboom,ripple,wireframe,torpedo
vim.g.neovide_cursor_vfx_opacity = "500.0"
vim.g.neovide_cursor_vfx_particle_lifetime = 1.5
vim.o.fileencoding = 'utf-8'
vim.cmd('set number relativenumber')
vim.cmd('set termguicolors')
vim.cmd('set tabstop=4')
vim.cmd('syntax on')

local opts = { noremap=true, silent=true }

local function quickfix()
    vim.lsp.buf.code_action({
        filter = function(a) return a.isPreferred end,
        apply = true
    })
end

vim.keymap.set('n', 'cf', quickfix, opts)
