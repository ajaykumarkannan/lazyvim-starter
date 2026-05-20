-- Search centering
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Prev search result (centered)" })

-- Buffer navigation
vim.keymap.set("n", "<leader>z", "<cmd>bp<cr>", { desc = "Previous Buffer" })
vim.keymap.set("n", "<leader>x", "<cmd>bn<cr>", { desc = "Next Buffer" })
vim.keymap.set("n", "<leader>c", "<cmd>bd<cr>", { desc = "Close Buffer" })

-- Save
vim.keymap.set("n", "<leader>s", "<cmd>w<cr>", { desc = "Save File" })

-- Splits
vim.keymap.set("n", "<leader>h", "<cmd>split<cr>", { desc = "Horizontal Split" })
vim.keymap.set("n", "<leader>v", "<cmd>vsplit<cr>", { desc = "Vertical Split" })

-- Set CWD
vim.keymap.set("n", "<leader>.", "<cmd>lcd %:p:h<cr>", { desc = "Set CWD to file dir" })

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Diagnostics
vim.keymap.set("n", "<leader>Cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })

-- Command abbreviations for typos
vim.cmd("cnoreabbrev W! w!")
vim.cmd("cnoreabbrev Q! q!")
vim.cmd("cnoreabbrev Wq wq")
vim.cmd("cnoreabbrev wQ wq")
vim.cmd("cnoreabbrev WQ wq")
vim.cmd("cnoreabbrev W w")
vim.cmd("cnoreabbrev Q q")

-- Trouble
vim.keymap.set("n", "<leader>Xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
vim.keymap.set("n", "<leader>XX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer Diagnostics" })
vim.keymap.set("n", "<leader>Xs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Symbols (Trouble)" })
vim.keymap.set("n", "<leader>Xl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", { desc = "LSP Definitions" })
vim.keymap.set("n", "<leader>XL", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List" })
vim.keymap.set("n", "<leader>XQ", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List" })

-- Flash
vim.keymap.set({ "n", "x", "o" }, "s", function() require("flash").jump() end, { desc = "Flash" })
vim.keymap.set({ "n", "x", "o" }, "S", function() require("flash").treesitter() end, { desc = "Flash Treesitter" })

-- Grug-far
vim.keymap.set("n", "<leader>sr", function() require("grug-far").open() end, { desc = "Search and Replace" })

-- Snacks picker
vim.keymap.set("n", "<leader><space>", function() require("snacks").picker.files() end, { desc = "Find Files" })
vim.keymap.set("n", "<leader>ff", function() require("snacks").picker.files() end, { desc = "Find Files" })
vim.keymap.set("n", "<leader>fg", function() require("snacks").picker.grep() end, { desc = "Grep" })
vim.keymap.set("n", "<leader>fb", function() require("snacks").picker.buffers() end, { desc = "Buffers" })
vim.keymap.set("n", "<leader>fh", function() require("snacks").picker.help() end, { desc = "Help" })
vim.keymap.set("n", "<leader>fr", function() require("snacks").picker.recent() end, { desc = "Recent Files" })
vim.keymap.set("n", "<leader>fw", function() require("snacks").picker.grep_word() end, { desc = "Grep Word" })

-- Snacks file explorer
vim.keymap.set("n", "<leader>e", function() require("snacks").explorer() end, { desc = "File Explorer" })

-- Persistence (session)
vim.keymap.set("n", "<leader>qs", function() require("persistence").load() end, { desc = "Restore Session" })
vim.keymap.set("n", "<leader>ql", function() require("persistence").load({ last = true }) end, { desc = "Restore Last Session" })
vim.keymap.set("n", "<leader>qd", function() require("persistence").stop() end, { desc = "Don't Save Current Session" })

-- Sidekick
vim.keymap.set({ "n", "t", "i", "x" }, "<c-.>", function() require("sidekick.cli").toggle() end, { desc = "Sidekick Toggle" })
vim.keymap.set("n", "<leader>aa", function() require("sidekick.cli").toggle() end, { desc = "Sidekick Toggle CLI" })
vim.keymap.set("n", "<leader>as", function() require("sidekick.cli").select() end, { desc = "Select CLI" })
vim.keymap.set("n", "<leader>ad", function() require("sidekick.cli").close() end, { desc = "Detach a CLI Session" })
vim.keymap.set({ "x", "n" }, "<leader>at", function() require("sidekick.cli").send({ msg = "{this}" }) end, { desc = "Send This" })
vim.keymap.set("n", "<leader>af", function() require("sidekick.cli").send({ msg = "{file}" }) end, { desc = "Send File" })
vim.keymap.set("x", "<leader>av", function() require("sidekick.cli").send({ msg = "{selection}" }) end, { desc = "Send Visual Selection" })
vim.keymap.set({ "n", "x" }, "<leader>ap", function() require("sidekick.cli").prompt() end, { desc = "Sidekick Select Prompt" })
vim.keymap.set("n", "<leader>ac", function() require("sidekick.cli").toggle({ name = "claude", focus = true }) end, { desc = "Sidekick Toggle Claude" })
vim.keymap.set("n", "<leader>ak", function() require("sidekick.cli").toggle({ name = "kiro", focus = true }) end, { desc = "Sidekick Toggle Kiro" })
vim.keymap.set("n", "<leader>ao", function() require("sidekick.cli").toggle({ name = "opencode", focus = true }) end, { desc = "Sidekick Toggle OpenCode" })

-- Sidekick NES (next edit suggestion)
vim.keymap.set("n", "<tab>", function()
  if not require("sidekick").nes_jump_or_apply() then
    return "<Tab>"
  end
end, { expr = true, desc = "Goto/Apply Next Edit Suggestion" })
