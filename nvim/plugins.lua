local plugins = {

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "go",
        "python",
        "json",
        "java",
        "markdown",
        "rust",
        "json",
        "c",
        "cpp",
        "bash",
        "fish",
        "html",
        "javascript",
      },
    },
  },

  -- In order to modify the `lspconfig` configuration:
{
  "neovim/nvim-lspconfig",
   opts = {
      inlay_hints = { enabled = true },
    },
   config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
   end,
},

  -- {
  --   "mfussenegger/nvim-jdtls",
  --   lazy = false,
  -- },


  {
    "seandewar/killersheep.nvim",
    cmd = "KillKillKill",
  config = function()
    require("killersheep").setup {
  gore = true,           -- Enables/disables blood and gore.
  keymaps = {
    move_left = "h",     -- Keymap to move cannon to the left.
    move_right = "l",    -- Keymap to move cannon to the right.
    shoot = "<Space>",   -- Keymap to shoot the cannon.
  },
}
    end
  },

{
    'eandrju/cellular-automaton.nvim',
    cmd = "CellularAutomaton",
},

  {
    "CRAG666/code_runner.nvim",
    cmd = "RunFile",
    config = function()
      require('code_runner').setup({
        filetype = {
          java = {
            "cd $dir &&",
            "javac $fileName &&",
            "java $fileNameWithoutExt &&",
            "rm *.class",
          },
          python = { "cd $dir && python $fileName" },
          cpp = { "cd $dir && clang++ -std=c++20 $fileName && ./a.out && rm ./a.out" },
          c = { "cd $dir && gcc $fileName && ./a.out && rm ./a.out" },
          go = { "cd $dir && go run $fileName" },
          rust = { "cd $dir && rustc $fileName && ./$fileNameWithoutExt && rm ./$fileNameWithoutExt" },
        },
})
    end
  },

{
  "folke/twilight.nvim",
  cmd = "Twilight",
  opts = {
  dimming = {
    alpha = 0.25, -- amount of dimming
    -- we try to get the foreground from the highlight groups or fallback color
    color = { "Normal", "#ffffff" },
    term_bg = "#000000", -- if guibg=NONE, this will be used to calculate text color
    inactive = false, -- when true, other windows will be fully dimmed (unless they contain the same buffer)
  },
  context = 10, -- amount of lines we will try to show around the current line
  treesitter = true, -- use treesitter when available for the filetype
  -- treesitter is used to automatically expand the visible text,
  -- but you can further control the types of nodes that should always be fully expanded
  expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
    "function",
    "method",
    "table",
    "if_statement",
  },
  exclude = {}, -- exclude these filetypes
}
},

  {
    "ellisonleao/glow.nvim",
    config = true,
    cmd = "Glow"
  },


  {
  'gen740/SmoothCursor.nvim',
  lazy = false,
  config = function()
    require('smoothcursor').setup({
    autostart = true,
    cursor = "",              -- cursor shape (need nerd font)
    texthl = "SmoothCursor",   -- highlight group, default is { bg = nil, fg = "#FFD400" }
    linehl = nil,              -- highlight sub-cursor line like 'cursorline', "CursorLine" recommended
    type = "exp",          -- define cursor movement calculate function, "default" or "exp" (exponential).
    fancy = {
        enable = true,        -- enable fancy mode
        head = { cursor = "󰙴 ", texthl = "SmoothCursor", linehl = nil },
        --head = { cursor = "▷", texthl = "SmoothCursor", linehl = nil },
        body = {
            { cursor = "󰥳 ", texthl = "SmoothCursorRed" },
            { cursor = "󰏉", texthl = "SmoothCursorOrange" },
            { cursor = "󰤇 ", texthl = "SmoothCursorYellow" },
            { cursor = "󰟟 ", texthl = "SmoothCursorGreen" },
            { cursor = "", texthl = "SmoothCursorAqua" },
            { cursor = "󰟢 ", texthl = "SmoothCursorBlue" },
            { cursor = "󱅻 ", texthl = "SmoothCursorPurple" },
        },
        tail = { cursor = nil, texthl = "SmoothCursor" }
    },
    flyin_effect = nil,        -- "bottom" or "top"
    speed = 25,                -- max is 100 to stick to your current position
    intervals = 35,            -- tick interval
    priority = 10,             -- set marker priority
    timeout = 3000,            -- timout for animation
    threshold = 3,             -- animate if threshold lines jump
    disable_float_win = false, -- disable on float window
    enabled_filetypes = nil,   -- example: { "lua", "vim" }
    disabled_filetypes = nil,  -- this option will be skipped if enabled_filetypes is set. example: { "TelescopePrompt", "NvimTree" }
})
  end
},



 {
   "williamboman/mason.nvim",
   opts = {
      ensure_installed = {
        "prettier",
      },
    },
  },
}

return plugins
