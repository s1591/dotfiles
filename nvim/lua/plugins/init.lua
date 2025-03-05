return{
    {
        "stevearc/conform.nvim",
        --event = 'BufWritePre', -- uncomment for format on save
        config = function()
            require "configs.conform"
        end,
    },

    {
        "neovim/nvim-lspconfig",
        config = function()
            require("nvchad.configs.lspconfig").defaults()
            require "configs.lspconfig"
        end,
    },

    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                "lua-language-server",
                "stylua",
                "prettier",
            },
        },
    },

    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "vim",
                "lua",
                "vimdoc",
                "html",
                "css",
                "go",
                "python",
                "rust",
                "java",
                "json",
                "toml",
                "yaml",
                "ini",
                "c",
                "cpp",
            },
        },
    },

    {
        "gen740/SmoothCursor.nvim",
        lazy = false,
        config = function()
            require "configs.smoothcursor"
        end,
    },

    {
        "rcarriga/nvim-notify",
        lazy = false,
        config = function()
            require("notify").setup {
                timeout = 3000,
                stages = "slide",
                background_colour = "#000000",
            }
            vim.notify = require "notify"
        end,
    },

    {
        "CRAG666/code_runner.nvim",
        cmd = "RunFile",
        config = function()
            require("code_runner").setup {
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
                    go = { "cd $dir && go run ." },
                    --rust = { "cd $dir && rustc $fileName && ./$fileNameWithoutExt && rm ./$fileNameWithoutExt" },
                },
            }
        end,
    },
}
