local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "tsserver", "clangd" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- 
-- lspconfig.pyright.setup { blabla}
local util = require "lspconfig/util"


lspconfig.rust_analyzer.setup({
  on_attach =on_attach ,
  capabilities = capabilities,
  filetypes = {"rust"},
  root_dir = lspconfig.util.root_pattern("Cargo.toml"),
})

lspconfig.gopls.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = {"gopls"},
  filetypes = {"go","gomod","gowork", "gotmpl"},
  root_dir = util.root_pattern("go.work","go.mod",".git"),
  settings = {
    gopls = {
      completeUnimported =true ,
      usePlaceholders = true ,
      analyses = {
        unusedparams = true ,
      }
    },
  },
  {
    "jose-elias-alvrez/null-ls.nvim",
    ft ="go",
    opts = function()
      return require "custom.configs.null-ls"
    end,
  },
}
