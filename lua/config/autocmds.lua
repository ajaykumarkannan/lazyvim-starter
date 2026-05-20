-- LLVM/TableGen file types
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.ll",
  callback = function()
    vim.bo.filetype = "llvm"
  end,
})
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.td",
  callback = function()
    vim.bo.filetype = "tablegen"
  end,
})

-- Strip trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    local cursor = vim.api.nvim_win_get_cursor(0)
    vim.cmd([[%s/\s\+$//e]])
    pcall(vim.api.nvim_win_set_cursor, 0, cursor)
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Obsidian vault sync
local obsidian_sync = vim.api.nvim_create_augroup("ObsidianSync", { clear = true })
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

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
  group = obsidian_sync,
  pattern = "*.md",
  callback = function()
    if obsidian_bufs[vim.api.nvim_get_current_buf()] then
      vim.cmd("checktime")
    end
  end,
})

local save_timer = vim.uv.new_timer()

local function save_buf(buf)
  if not vim.api.nvim_buf_is_valid(buf) or not vim.bo[buf].modified or vim.bo[buf].buftype ~= "" then
    return
  end
  vim.api.nvim_buf_call(buf, function()
    vim.cmd("noautocmd write")
  end)
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
