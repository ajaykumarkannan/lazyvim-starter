-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Obsidian vault sync: auto-reload and auto-save for vault notes so that
-- edits in the Obsidian app and Neovim stay in sync.
--
-- Uses the new obsidian-nvim/obsidian.nvim User autocmd events
-- (ObsidianNoteEnter / ObsidianNoteLeave) to track whether the current
-- buffer belongs to the vault, avoiding repeated get_client() calls.

local obsidian_sync = vim.api.nvim_create_augroup("ObsidianSync", { clear = true })

-- Track which buffers are obsidian notes via the plugin's own events.
local obsidian_bufs = {}

vim.api.nvim_create_autocmd("User", {
  group = obsidian_sync,
  pattern = "ObsidianNoteEnter",
  callback = function(ev)
    obsidian_bufs[ev.buf] = true
  end,
})

vim.api.nvim_create_autocmd("User", {
  group = obsidian_sync,
  pattern = "ObsidianNoteLeave",
  callback = function(ev)
    obsidian_bufs[ev.buf] = nil
  end,
})

-- Reload buffer when the file changes on disk (e.g. saved by Obsidian app).
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
  group = obsidian_sync,
  pattern = "*.md",
  callback = function()
    if obsidian_bufs[vim.api.nvim_get_current_buf()] then
      vim.cmd("checktime")
    end
  end,
})

-- Auto-save vault notes so changes flow back to the Obsidian app.
vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave", "InsertLeave", "TextChanged" }, {
  group = obsidian_sync,
  pattern = "*.md",
  callback = function()
    local buf = vim.api.nvim_get_current_buf()
    if obsidian_bufs[buf] and vim.bo[buf].modified and vim.bo[buf].buftype == "" then
      vim.cmd("silent! write")
    end
  end,
})
