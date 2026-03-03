-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Buffer navigation (from .vimrc)
vim.keymap.set("n", "<leader>z", "<cmd>bp<cr>", { desc = "Previous Buffer" })
vim.keymap.set("n", "<leader>x", "<cmd>bn<cr>", { desc = "Next Buffer" })
vim.keymap.set("n", "<leader>c", "<cmd>bd<cr>", { desc = "Close Buffer" })

-- Save with leader+s (from .vimrc)
vim.keymap.set("n", "<leader>s", "<cmd>w<cr>", { desc = "Save File" })

-- Split windows (from .vimrc)
vim.keymap.set("n", "<leader>h", "<cmd>split<cr>", { desc = "Horizontal Split" })
vim.keymap.set("n", "<leader>v", "<cmd>vsplit<cr>", { desc = "Vertical Split" })

-- Set working directory to current file (from .vimrc)
vim.keymap.set("n", "<leader>.", "<cmd>lcd %:p:h<cr>", { desc = "Set CWD to file dir" })

-- Command abbreviations for typos (from .vimrc)
vim.cmd("cnoreabbrev W! w!")
vim.cmd("cnoreabbrev Q! q!")
vim.cmd("cnoreabbrev Wq wq")
vim.cmd("cnoreabbrev wQ wq")
vim.cmd("cnoreabbrev WQ wq")
vim.cmd("cnoreabbrev W w")
vim.cmd("cnoreabbrev Q q")
