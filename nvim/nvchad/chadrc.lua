---@type ChadrcConfig 
 local M = {}

require("custom.vimsetts")

 M.ui = {
  theme_toggle = { "catppuccin", "gruvbox_light" },
  theme = 'catppuccin',
    statusline = {
    theme = "default", -- default/vscode/vscode_colored/minimal
    -- default/round/block/arrow separators work only for default statusline theme
    -- round and block will work for minimal theme only
    separator_style = "default",
   -- overriden_modules = nil,
  },
    tabufline = {
    lazyload = true,
    -- overriden_modules = nil,
  },
}

M.plugins = "custom.plugins"
M.mappings = require "custom.mappings"

return M
