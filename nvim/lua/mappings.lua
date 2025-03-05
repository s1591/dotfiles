require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle nvim tree" })
map("n", "<leader>rf", ":RunFile<CR>", { noremap = true, silent = false })
map("n", "<leader>k", vim.lsp.buf.hover, { desc = "Lsp hover information" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
