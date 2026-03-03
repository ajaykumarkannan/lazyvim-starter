-- Remap LazyVim defaults that conflict with custom keymaps
-- and register custom keymaps in which-key minimap
return {
  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      -- Register custom keymap groups/descriptions
      opts.spec = opts.spec or {}

      -- Add custom buffer navigation keymaps to which-key
      table.insert(opts.spec, { "<leader>z", desc = "Previous Buffer" })
      table.insert(opts.spec, { "<leader>x", desc = "Next Buffer" })
      table.insert(opts.spec, { "<leader>c", desc = "Close Buffer" })
      table.insert(opts.spec, { "<leader>s", desc = "Save File" })
      table.insert(opts.spec, { "<leader>h", desc = "Horizontal Split" })
      table.insert(opts.spec, { "<leader>v", desc = "Vertical Split" })
      table.insert(opts.spec, { "<leader>.", desc = "Set CWD to file dir" })

      return opts
    end,
  },

  -- Remap LazyVim's <leader>c (code) group to <leader>C
  {
    "LazyVim/LazyVim",
    opts = function(_, opts)
      -- Remap the code group from <leader>c to <leader>C
      local keys = {
        { "<leader>C", group = "code" },
        { "<leader>Cl", "<cmd>LspInfo<cr>", desc = "Lsp Info" },
        { "<leader>Cd", vim.diagnostic.open_float, desc = "Line Diagnostics" },
      }

      opts.keys = vim.list_extend(opts.keys or {}, keys)
      return opts
    end,
  },

  -- Remap LazyVim's <leader>x (diagnostics/quickfix) group to <leader>X
  {
    "folke/trouble.nvim",
    keys = {
      { "<leader>X", "", desc = "+diagnostics/quickfix", mode = { "n", "v" } },
      { "<leader>Xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>XX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
      { "<leader>Xs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
      { "<leader>Xl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions / references / ... (Trouble)" },
      { "<leader>XL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
      { "<leader>XQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
      -- Disable the original <leader>x mappings
      { "<leader>x", false },
      { "<leader>xx", false },
      { "<leader>xX", false },
      { "<leader>xs", false },
      { "<leader>xl", false },
      { "<leader>xL", false },
      { "<leader>xQ", false },
    },
  },

  -- Remap LazyVim's default <leader>c LSP mappings to <leader>C
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ["*"] = {
          keys = {
            -- Disable original <leader>c mappings
            { "<leader>ca", false },
            { "<leader>cc", false },
            { "<leader>cC", false },
            { "<leader>cr", false },
            { "<leader>cA", false },
            -- Remap code action from <leader>ca to <leader>Ca
            { "<leader>Ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" }, has = "codeAction" },
            -- Remap code lens from <leader>cc to <leader>Cc
            { "<leader>Cc", vim.lsp.codelens.run, desc = "Run Codelens", mode = { "n", "v" }, has = "codeLens" },
            { "<leader>CC", vim.lsp.codelens.refresh, desc = "Refresh & Display Codelens", mode = { "n" }, has = "codeLens" },
            -- Remap rename from <leader>cr to <leader>Cr
            { "<leader>Cr", vim.lsp.buf.rename, desc = "Rename", has = "rename" },
            -- Remap source action from <leader>cA to <leader>CA
            { "<leader>CA", vim.lsp.buf.code_action, desc = "Source Action", has = "codeAction", mode = { "n" } },
          },
        },
      },
    },
  },
}
