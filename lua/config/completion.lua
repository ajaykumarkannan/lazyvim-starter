require("blink.cmp").setup({
  fuzzy = { implementation = "prefer_rust_with_warning" },
  completion = {
    list = { selection = { preselect = false, auto_insert = false } },
    menu = { auto_show = true },
  },
  keymap = {
    preset = "super-tab",
    ["<CR>"] = {},
  },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },
})
