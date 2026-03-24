return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  ---@module 'obsidian'
  ---@type obsidian.config.ClientOpts
  opts = {
    workspaces = {
      {
        name = "work",
        path = "~/Documents/Obsidian_Vault/",
      },
    },

    daily_notes = {
      folder = "Periodic/Daily",
    },

    disable_frontmatter = true,

    -- Disable the default <CR> smart_action (which follows links, toggles
    -- checkboxes, etc.) so it doesn't interfere with normal <CR> behavior.
    callbacks = {
      enter_note = function(note)
        pcall(vim.keymap.del, "n", "<CR>", { buffer = true })
        vim.api.nvim_exec_autocmds("User", { pattern = "ObsidianNoteEnter" })
      end,
      leave_note = function(note)
        vim.api.nvim_exec_autocmds("User", { pattern = "ObsidianNoteLeave" })
      end,
    },
  },
}
