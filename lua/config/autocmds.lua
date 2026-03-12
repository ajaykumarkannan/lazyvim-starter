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
local obsidian_sync = vim.api.nvim_create_augroup("ObsidianSync", { clear = true })

--- Check if the current buffer is a note inside an obsidian.nvim workspace.
local function is_obsidian_note()
  local ok, client = pcall(require("obsidian").get_client)
  if not ok or not client then
    return false
  end
  return client:path_is_note(vim.api.nvim_buf_get_name(0))
end

-- Reload buffer when the file changes on disk (e.g. saved by Obsidian app).
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
  group = obsidian_sync,
  pattern = "*.md",
  callback = function()
    if is_obsidian_note() then
      vim.cmd("checktime")
    end
  end,
})

-- Auto-save vault notes so changes flow back to the Obsidian app.
vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave", "InsertLeave", "TextChanged" }, {
  group = obsidian_sync,
  pattern = "*.md",
  callback = function()
    if is_obsidian_note() and vim.bo.modified and vim.bo.buftype == "" then
      vim.cmd("silent! write")
    end
  end,
})
