return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   -- refer to `:h file-pattern` for more examples
  --   "BufReadPre path/to/my-vault/*.md",
  --   "BufNewFile path/to/my-vault/*.md",
  -- },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",

    -- see below for full list of optional dependencies 👇
  },
  opts = {
    mappings = {
      ["gf"] = {
        action = function()
          return require("obsidian").util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true },
      },
      ["<leader>ot"] = {
        action = function()
          return "<cmd>ObsidianToggleCheckbox<CR>"
        end,
        opts = { buffer = true, expr = true, desc = "Obsidian: Toggle checkbox" },
      },
      -- Disable the default <CR> mapping to prevent accidental toggling
    },
    workspaces = {
      {
        name = "work",
        path = "~/Documents/Obsidian_Vault/",
      },
    },

    -- see below for full list of options 👇
    daily_notes = {
      folder = "Periodic/Daily",
    },
  },
}
