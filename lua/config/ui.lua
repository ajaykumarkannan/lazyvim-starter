-- Colorscheme
require("nightfox").setup({
  palettes = {
    carbonfox = {
      fg1 = "#c8c8cb",
    },
  },
  options = {
    styles = {
      comments = "italic",
    },
  },
})
vim.cmd.colorscheme("carbonfox")

-- Lualine
require("lualine").setup({
  sections = {
    lualine_a = {
      {
        "mode",
        fmt = function(str)
          return str:sub(1, 1)
        end,
      },
    },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = { "filename" },
    lualine_x = { "encoding", "fileformat", "filetype" },
    lualine_y = { "progress" },
    lualine_z = {},
  },
})

-- Noice
require("noice").setup({
  cmdline = {
    view = "cmdline",
  },
  lsp = {
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
  },
})

-- Snacks
require("snacks").setup({
  picker = { enabled = true },
  explorer = { enabled = true },
  notifier = { enabled = true },
  indent = { enabled = true },
  dashboard = {
    enabled = true,
    preset = {
      header = [[
 Ajay's nvim]],
    },
    sections = {
      { section = "header" },
      { section = "keys", gap = 1, padding = 1 },
      { section = "recent_files", padding = 1 },
    },
  },
})

-- Which-key
require("which-key").setup()

-- Mini.ai
require("mini.ai").setup()

-- Mini.icons
require("mini.icons").setup()

-- Gitsigns
require("gitsigns").setup()

-- Todo-comments
require("todo-comments").setup()

-- Trouble
require("trouble").setup()

-- Colorizer
require("colorizer").setup({
  filetypes = { "css", "scss", "html", "javascript", "typescript", "lua" },
  user_default_options = {
    css = true,
    names = false,
    tailwind = false,
    mode = "background",
  },
})

-- Flash
require("flash").setup()

-- Grug-far
require("grug-far").setup()

-- Bufferline
require("bufferline").setup()

-- Persistence
require("persistence").setup()

-- Conform (formatting)
require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_format = "fallback",
  },
})

-- Nvim-lint
local lint = require("lint")
lint.linters_by_ft = {
  lua = { "luacheck" },
}
vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
  callback = function()
    lint.try_lint()
  end,
})
