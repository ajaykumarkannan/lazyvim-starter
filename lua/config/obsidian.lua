require("obsidian").setup({
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
  callbacks = {
    enter_note = function()
      pcall(vim.keymap.del, "n", "<CR>", { buffer = true })
      vim.api.nvim_exec_autocmds("User", { pattern = "ObsidianNoteEnter" })
    end,
    leave_note = function()
      vim.api.nvim_exec_autocmds("User", { pattern = "ObsidianNoteLeave" })
    end,
  },
})
