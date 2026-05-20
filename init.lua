-- Options first (mapleader must be set before plugins)
require("config.options")

-- Install and load plugins via vim.pack
require("packages")

-- Plugin setup
require("config.lsp")
require("config.treesitter")
require("config.completion")
require("config.ui")
require("config.obsidian")
require("config.sidekick")

-- Keymaps and autocmds last
require("config.keymaps")
require("config.autocmds")
