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
-- Only check on focus/buffer enter (not CursorHold, which fires every
-- 200ms with LazyVim's default updatetime and adds unnecessary disk I/O).
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
  group = obsidian_sync,
  pattern = "*.md",
  callback = function()
    if obsidian_bufs[vim.api.nvim_get_current_buf()] then
      vim.cmd("checktime")
    end
  end,
})

-- Auto-save vault notes so changes flow back to the Obsidian app.
-- Uses `noautocmd` to avoid re-entrancy from BufWritePre hooks, then
-- explicitly bumps the file's mtime so Obsidian's fs-watcher picks it up.
local save_timer = vim.uv.new_timer()

local function save_buf(buf)
  if not vim.api.nvim_buf_is_valid(buf) or not vim.bo[buf].modified or vim.bo[buf].buftype ~= "" then
    return
  end
  vim.api.nvim_buf_call(buf, function()
    vim.cmd("noautocmd write")
  end)
  -- Bump mtime so Obsidian's file watcher sees the change, then
  -- re-sync Neovim's internal timestamp so it doesn't warn about
  -- the file being "modified outside of Vim" on the next :w.
  local path = vim.api.nvim_buf_get_name(buf)
  if path ~= "" then
    local now = vim.uv.hrtime() / 1e9
    vim.uv.fs_utime(path, now, now)
    vim.api.nvim_buf_call(buf, function()
      vim.cmd("silent! checktime")
    end)
  end
end

vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave", "InsertLeave" }, {
  group = obsidian_sync,
  pattern = "*.md",
  callback = function(ev)
    local buf = ev.buf
    if not obsidian_bufs[buf] then
      return
    end
    save_timer:stop()
    save_timer:start(200, 0, vim.schedule_wrap(function()
      save_buf(buf)
    end))
  end,
})
