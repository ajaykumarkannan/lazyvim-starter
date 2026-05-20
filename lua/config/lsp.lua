require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls",
  },
  automatic_installation = true,
})

require("lazydev").setup()

local capabilities = require("blink.cmp").get_lsp_capabilities()

local on_attach = function(_, buf)
  local map = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = buf, desc = desc })
  end
  map("n", "gd", vim.lsp.buf.definition, "Go to Definition")
  map("n", "gr", vim.lsp.buf.references, "References")
  map("n", "gI", vim.lsp.buf.implementation, "Go to Implementation")
  map("n", "gy", vim.lsp.buf.type_definition, "Go to Type Definition")
  map("n", "K", vim.lsp.buf.hover, "Hover")
  map("n", "gK", vim.lsp.buf.signature_help, "Signature Help")
  map("i", "<C-k>", vim.lsp.buf.signature_help, "Signature Help")
  map("n", "<leader>Ca", vim.lsp.buf.code_action, "Code Action")
  map("v", "<leader>Ca", vim.lsp.buf.code_action, "Code Action")
  map("n", "<leader>Cr", vim.lsp.buf.rename, "Rename")
  map("n", "<leader>Cl", "<cmd>checkhealth lsp<cr>", "LSP Info")
end

-- Default config for all LSP servers
vim.lsp.config("*", {
  capabilities = capabilities,
  on_attach = on_attach,
})

-- Lua LS
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
      diagnostics = { globals = { "vim" } },
    },
  },
})

-- Markdown Oxide (install via: cargo install markdown-oxide)
vim.lsp.config("markdown_oxide", {})

-- Enable LSP servers
vim.lsp.enable("lua_ls")
vim.lsp.enable("markdown_oxide")

-- Auto-enable servers installed by mason-lspconfig
vim.api.nvim_create_autocmd("User", {
  pattern = "MasonLspconfigReady",
  once = true,
  callback = function()
    local servers = require("mason-lspconfig").get_installed_servers()
    for _, server in ipairs(servers) do
      pcall(vim.lsp.enable, server)
    end
  end,
})
