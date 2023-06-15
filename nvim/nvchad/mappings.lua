---@type MappingsTable
local M = {}

-- In order to disable a default keymap, use
M.disabled = {
  n = {
      ["<leader>h"] = "",
      ["<C-a>"] = ""
  }
}

-- Your custom mappings
M.misc = {

  i = {
     ["jk"] = { "<ESC>", "escape insert mode" , opts = { nowait = true }},
  }
}

M.nvimtree = {
plugin = true,
n = {
["<leader>ftt"] = { "<cmd> NvimTreeToggle <CR>", "Toggle nvimtree" },
["<leader>ftf"] = { "<cmd> NvimTreeFocus <CR>", "Focus nvimtree" },
}
}

M.fun = {
  n = {
    ["<leader>fml"] = {"<cmd>CellularAutomaton make_it_rain<CR>", "Melt a file"},
    ["<leader>fmg"] = {"<cmd>CellularAutomaton game_of_life<CR>", "conways game of life"},
    ["<leader>fmk"] = {"<cmd>KillKillKill<CR>","play killersheep"},
  }
}

M.markdown = {
  n = {
    ["<leader>mp"] = {"<cmd>Glow<CR>", "Preview markdown using glow"},
  }
}

M.twilight = {
  n = {
    ["<leader>fme"] = {"<cmd>Twilight<CR>", "enable twilight"},
    ["<leader>fmd"] = {"<cmd>TwilightDisable<CR>", "disable twilight"},
  }

}

return M

