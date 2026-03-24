-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.mapleader = ","

-- Word wrap settings (from .vimrc)
vim.opt.breakindent = true -- Indent word-wrapped lines as much as parent
vim.opt.linebreak = true -- Don't split words when wrapping

-- Disable swap/backup (from .vimrc)
vim.opt.swapfile = false
vim.opt.backup = false

-- Search centering (n/N will center the match on screen)
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Prev search result (centered)" })

-- Scrolloff - keep 3 lines visible above/below cursor
vim.opt.scrolloff = 3

-- Disable snacks animation
vim.g.snacks_animate = false
