local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = { "gopls","pyright","bashls","jsonls","html","clangd","eslint","cssls","jdtls" }

-- require'lspconfig'.gopls.setup{
--   cmd = {"gopls"},
--   filetypes = {"go","gomod","gowork","gotmpl"},
--   root_dir = root_pattern("go.work", "go.mod", ".git"),
--   single_file_support = true
-- }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

