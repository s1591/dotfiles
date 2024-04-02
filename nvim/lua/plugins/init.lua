-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
	local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
	vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
	-- theme
	{ 'catppuccin/nvim',                            name = 'catppuccin',                        priority = 1000 },
	-- which key
	{ 'folke/which-key.nvim',                       opts = {} },
	-- nvim colorizer
	{ 'NvChad/nvim-colorizer.lua' },
	-- commenter
	{ 'numToStr/Comment.nvim',                      opts = {} },
	-- toggle term
	{ 'akinsho/toggleterm.nvim',                    version = "*",                              config = true },
	-- file explorer
	{ "nvim-telescope/telescope-file-browser.nvim", dependencies = { "nvim-lua/plenary.nvim" }, },
	-- lsp
	{ 'neovim/nvim-lspconfig',                      dependencies = { 'j-hui/fidget.nvim' }, },
	-- nvim notify
	{
		'rcarriga/nvim-notify',
		config =
			function()
				vim.notify = require("notify")
			end
	},
	-- auto pairs
	{ "windwp/nvim-autopairs" },
	-- cmp
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
	-- lualine
	{ 'nvim-lualine/lualine.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' } },
	-- smooth cursor
	{ 'gen740/SmoothCursor.nvim',  lazy = false },
	-- code runner
	{ 'CRAG666/code_runner.nvim',  cmd = "RunFile" },
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
	--tree sitter
	{
		'nvim-treesitter/nvim-treesitter',
		dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects', },
		build = ':TSUpdate',
	},

	-- cellular automaton
	{ 'eandrju/cellular-automaton.nvim' },


})
