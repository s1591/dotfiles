-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

local _normal = " 󱓞 ノーマル"
local _insert = "  インサート"
local _select = " 󰆏 セレクション"
local _command = " 󰘳 コマンド"

---@type ChadrcConfig
local M = {}

M.ui = {
    theme = "catppuccin",
    -- theme_toggle = { "palenight", "catppuccin" },
    transparency = true,

    hl_override = {
        Comment = { italic = true },
        ["@comment"] = { italic = true },
    },

    statusline = {
        theme = "default",
        modules = {
            mode = function()
                local utils = require "nvchad.stl.utils"
                local modes = utils.modes
                modes["n"] = { _normal, "Normal" }
                modes["v"] = { _select, "Select" }
                modes["i"] = { _insert, "Insert" }
                modes["c"] = { _command, "Command" }

                if not utils.is_activewin() then
                    return ""
                end
                local m = vim.api.nvim_get_mode().mode
                return "%#St_" .. modes[m][2] .. "mode#" .. modes[m][1] .. " "
            end,
        },
    },
}

return M
