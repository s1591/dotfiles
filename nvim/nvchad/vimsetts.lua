vim.o.guifont = "jetBrainsMono Nerd Font:h8"
vim.g.neovide_cursor_vfx_mode = "railgun" -- pixiedust,sonicboom,ripple,wireframe,torpedo
vim.g.neovide_cursor_vfx_opacity = "500.0"
vim.g.neovide_cursor_vfx_particle_lifetime = 1.5
vim.o.fileencoding = 'utf-8'
vim.cmd('set number relativenumber')
vim.cmd('set termguicolors')
vim.cmd('set tabstop=4')
vim.cmd('syntax on')

-- local autocmd = vim.api.nvim_create_autocmd
--
-- autocmd({ 'ModeChanged' }, {
--   callback = function()
--     local current_mode = vim.fn.mode()
--     if current_mode == 'n' then
--       vim.api.nvim_set_hl(0, 'SmoothCursor', { fg = '#8aa872' })
--       vim.fn.sign_define('smoothcursor', { text = '' })
--     elseif current_mode == 'v' then
--       vim.api.nvim_set_hl(0, 'SmoothCursor', { fg = '#bf616a' })
--       vim.fn.sign_define('smoothcursor', { text = '' })
--     elseif current_mode == 'V' then
--       vim.api.nvim_set_hl(0, 'SmoothCursor', { fg = '#bf616a' })
--       vim.fn.sign_define('smoothcursor', { text = '' })
--     elseif current_mode == '�' then
--       vim.api.nvim_set_hl(0, 'SmoothCursor', { fg = '#bf616a' })
--       vim.fn.sign_define('smoothcursor', { text = '' })
--     elseif current_mode == 'i' then
--       vim.api.nvim_set_hl(0, 'SmoothCursor', { fg = '#668aab' })
--       vim.fn.sign_define('smoothcursor', { text = '' })
--     end
--   end,
-- })
