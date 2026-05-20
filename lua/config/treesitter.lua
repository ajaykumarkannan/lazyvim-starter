-- nvim-treesitter on 0.12+ only handles parser installation
-- Highlighting and indenting are built into Neovim's vim.treesitter
require("nvim-treesitter").setup()

-- Install parsers (async, won't block startup after first run)
local parsers = {
  "bash", "c", "cpp", "html", "javascript", "json", "lua", "luadoc",
  "markdown", "markdown_inline", "python", "query", "regex", "tsx",
  "typescript", "vim", "vimdoc", "yaml",
}

local installed = require("nvim-treesitter").get_installed()
local installed_set = {}
for _, p in ipairs(installed) do
  installed_set[p] = true
end

local to_install = {}
for _, p in ipairs(parsers) do
  if not installed_set[p] then
    table.insert(to_install, p)
  end
end

if #to_install > 0 then
  require("nvim-treesitter").install(to_install)
end

-- Enable treesitter highlight and indent (built-in)
vim.api.nvim_create_autocmd("FileType", {
  callback = function(ev)
    if pcall(vim.treesitter.start, ev.buf) then
      vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})

-- Textobjects
require("nvim-treesitter-textobjects").setup({
  select = { lookahead = true },
})

local select_ts = require("nvim-treesitter-textobjects.select")
local move = require("nvim-treesitter-textobjects.move")

-- Select keymaps
local select_maps = {
  ["af"] = "@function.outer",
  ["if"] = "@function.inner",
  ["ac"] = "@class.outer",
  ["ic"] = "@class.inner",
  ["aa"] = "@parameter.outer",
  ["ia"] = "@parameter.inner",
}
for key, query in pairs(select_maps) do
  vim.keymap.set({ "x", "o" }, key, function()
    select_ts.select_textobject(query)
  end)
end

-- Move keymaps
local move_maps = {
  ["]f"] = { move.goto_next_start, "@function.outer" },
  ["]c"] = { move.goto_next_start, "@class.outer" },
  ["]a"] = { move.goto_next_start, "@parameter.inner" },
  ["]F"] = { move.goto_next_end, "@function.outer" },
  ["]C"] = { move.goto_next_end, "@class.outer" },
  ["[f"] = { move.goto_previous_start, "@function.outer" },
  ["[c"] = { move.goto_previous_start, "@class.outer" },
  ["[a"] = { move.goto_previous_start, "@parameter.inner" },
  ["[F"] = { move.goto_previous_end, "@function.outer" },
  ["[C"] = { move.goto_previous_end, "@class.outer" },
}
for key, spec in pairs(move_maps) do
  vim.keymap.set({ "n", "x", "o" }, key, function()
    spec[1](spec[2])
  end)
end

-- Autotag (auto-sets up via its plugin/ file)
-- ts-comments
require("ts-comments").setup()
