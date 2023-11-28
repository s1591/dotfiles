-- vim settings
-- plugins
-- plugin configs
-- keymaps
-- lsp


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
vim.o.guifont = "jetBrainsMono Nerd Font:h16"
vim.g.neovide_cursor_vfx_mode = "railgun" -- pixiedust,sonicboom,ripple,wireframe,torpedo,railgun
vim.g.neovide_cursor_vfx_opacity = "500.0"
vim.g.neovide_cursor_vfx_particle_lifetime = 1.5

-- install lazy.nvim
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)


require('lazy').setup({
  { 'mfussenegger/nvim-jdtls' },
  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',
    -- whichkey
  { 'folke/which-key.nvim', opts = {} },
  -- nvim colorizer
  {'NvChad/nvim-colorizer.lua'},
    -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },
  -- Toggle Term
  {'akinsho/toggleterm.nvim', version = "*", config = true},
  -- rose pine
  { 'rose-pine/neovim', name = 'rose-pine' },
  -- file explorer based on telescope
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = 
      { 
        "nvim-lua/plenary.nvim" 
      },
},

  -- lsp
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- 'williamboman/mason.nvim',
      -- 'williamboman/mason-lspconfig.nvim',
      { 'j-hui/fidget.nvim', opts = {} },
    },
  },

 -- nvim-notify
	{ 
		'rcarriga/nvim-notify',
    config = function()
      vim.notify = require("notify")
    end
  },

  {
        -- autopairs
        "windwp/nvim-autopairs",
        opts = {
          fast_wrap = {},
          disable_filetype = { "TelescopePrompt", "vim" },
        },
        config = function(_, opts)
          require("nvim-autopairs").setup(opts)

          -- setup cmp for autopairs
          local cmp_autopairs = require "nvim-autopairs.completion.cmp"
          require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
  },

  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
  },

  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        vim.keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk, { buffer = bufnr, desc = 'Preview git hunk' })

        -- don't override the built-in and fugitive keymaps
        local gs = package.loaded.gitsigns
        vim.keymap.set({ 'n', 'v' }, ']c', function()
          if vim.wo.diff then
            return ']c'
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = 'Jump to next hunk' })
        vim.keymap.set({ 'n', 'v' }, '[c', function()
          if vim.wo.diff then
            return '[c'
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = 'Jump to previous hunk' })
      end,
    },
  },

  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
  },

{
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  opts = {},
},

  -- lualine
  {
    'nvim-lualine/lualine.nvim',
     dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
     opts = {
        options = {
         icons_enabled = true,
         theme = 'auto',
         component_separators = { left = '', right = ''},
         section_separators = { left = '', right = ''},
       },
     },
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

  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },

}, {})
-- End plugins

-- vim.notify = require("notify")
vim.cmd[[colorscheme rose-pine]] -- catppuccin, tokyonight, rose-pine
require("colorizer").attach_to_buffer(0, { mode = "background", css = true})
require("tokyonight").setup({
  style = "moon", -- storm, moon, night
})
-- require('mason').setup()
-- require('mason-lspconfig').setup()

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')


-- key maps
vim.keymap.set('i', 'jk', '<ESC>', { silent = true })
vim.keymap.set('i', 'kj', '<ESC>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set('n', '<ESC>', '<cmd>noh<CR>', { silent = true })
vim.keymap.set('n', '<C-c>', '<cmd>%y+<CR>', { desc = 'Copy whole file' })
vim.keymap.set('n', '<C-s>', '<cmd>w<CR>', { desc = 'save file' })
-- vim.keymap.set('n', '<C-m>', '<cmd>Man<CR>', { desc = 'display man page of item under mouse' })
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })
vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sG', ':LiveGrepGitRoot<cr>', { desc = '[S]earch by [G]rep on Git Root' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })


-- Telescope live_grep in git root
-- Function to find the git root directory based on the current buffer's path
local function find_git_root()
  -- Use the current buffer's path as the starting point for the git search
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_dir
  local cwd = vim.fn.getcwd()
  -- If the buffer is not associated with a file, return nil
  if current_file == "" then
    current_dir = cwd
  else
    -- Extract the directory from the current file's path
    current_dir = vim.fn.fnamemodify(current_file, ":h")
  end

  -- Find the Git root directory from the current file's path
  local git_root = vim.fn.systemlist("git -C " .. vim.fn.escape(current_dir, " ") .. " rev-parse --show-toplevel")[1]
  if vim.v.shell_error ~= 0 then
    print("Not a git repository. Searching on current working directory")
    return cwd
  end
  return git_root
end

-- Custom live_grep function to search in git root
local function live_grep_git_root()
  local git_root = find_git_root()
  if git_root then
    require('telescope.builtin').live_grep({
      search_dirs = {git_root},
    })
  end
end

vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
-- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
vim.defer_fn(function()
  require('nvim-treesitter.configs').setup {
    -- Add languages to be installed here that you want installed for treesitter
    ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'javascript', 'typescript', 'vimdoc', 'vim', 'bash' },

    -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
    auto_install = false,

    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<c-space>',
        node_incremental = '<c-space>',
        scope_incremental = '<c-s>',
        node_decremental = '<M-space>',
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ['aa'] = '@parameter.outer',
          ['ia'] = '@parameter.inner',
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          [']m'] = '@function.outer',
          [']]'] = '@class.outer',
        },
        goto_next_end = {
          [']M'] = '@function.outer',
          [']['] = '@class.outer',
        },
        goto_previous_start = {
          ['[m'] = '@function.outer',
          ['[['] = '@class.outer',
        },
        goto_previous_end = {
          ['[M'] = '@function.outer',
          ['[]'] = '@class.outer',
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ['<leader>a'] = '@parameter.inner',
        },
        swap_previous = {
          ['<leader>A'] = '@parameter.inner',
        },
      },
    },
  }
end, 0)

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- document existing key chains
require('which-key').register {
  ['<leader>c'] = { 
    name = '[C]ode',
    _ = 'which_key_ignore'
  },
  ['<leader>d'] = {
    name = '[D]ocument',
    _ = 'which_key_ignore'
  },
  ['<leader>g'] = {
    name = '[G]it',
    _ = 'which_key_ignore' 
  },
  ['<leader>h'] = { 
    name = 'More git',
    _ = 'which_key_ignore' 
  },
  ['<leader>r'] = { 
    name = '[R]un | [R]ename',
    f = { '<cmd>RunFile<CR>', 'run file' },
  },
  ['<leader>s'] = {
    name = '[S]earch',
    _ = 'which_key_ignore' 
  },
  ['<leader>w'] = {
    name = '[W]indow',
    _ = 'which_key_ignore' 
  },
  ['<leader>t'] = {
    name = '[T]erm',
    t = { '<cmd>ToggleTerm<CR>', '[T]oggle Term' },
  },
  ['<leader>f'] = {
    name = '[F]ile',
    e = { '<cmd>Telescope file_browser<CR>', '[E]xplorer' },
  },
}

-- local servers = {
--   clangd = {},
--   gopls = {},
--   pyright = {},
--   rust_analyzer = {},
--
--   lua_ls = {
--     Lua = {
--       workspace = { checkThirdParty = false },
--       telemetry = { enable = false },
--       -- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
--       -- diagnostics = { disable = { 'missing-fields' } },
--     },
--   },
-- }


-- native lsp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local lspconfig = require "lspconfig"
local servers = { "gopls","pyright","bashls","jsonls","html","clangd","eslint","cssls","rust_analyzer" }
for _, lsp in ipairs(servers) do
lspconfig[lsp].setup {
     on_attach = on_attach,
     capabilities = capabilities,
   }
end

-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
--
-- -- Ensure the servers above are installed
-- local mason_lspconfig = require 'mason-lspconfig'
--
-- mason_lspconfig.setup {
--   ensure_installed = vim.tbl_keys(servers),
-- }
--
-- mason_lspconfig.setup_handlers {
--   function(server_name)
--     require('lspconfig')[server_name].setup {
--       capabilities = capabilities,
--       on_attach = on_attach,
--       settings = servers[server_name],
--       filetypes = (servers[server_name] or {}).filetypes,
--     }
--   end,
-- }

-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  completion = {
    completeopt = 'menu,menuone,noinsert'
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

