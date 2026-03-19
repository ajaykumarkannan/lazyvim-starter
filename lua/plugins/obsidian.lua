return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    legacy_commands = false, -- will be removed in next major release
    workspaces = {
      {
        name = "work",
        path = "~/Documents/Obsidian_Vault/",
      },
    },

    daily_notes = {
      folder = "Periodic/Daily",
    },

    -- disable_frontmatter is replaced by frontmatter.enabled in the new fork
    frontmatter = { enabled = false },

    -- Disable the default <CR> smart_action (which follows links, toggles
    -- checkboxes, etc.) so it doesn't interfere with normal <CR> behavior.
    callbacks = {
      enter_note = function(note)
        pcall(vim.keymap.del, "n", "<CR>", { buffer = true })
      end,
    },
  },
}
