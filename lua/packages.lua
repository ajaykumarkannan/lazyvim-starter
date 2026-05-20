local gh = function(repo)
  return "https://github.com/" .. repo
end

vim.pack.add({
  -- Dependencies (load before dependents)
  gh("nvim-lua/plenary.nvim"),
  gh("MunifTanjim/nui.nvim"),
  gh("echasnovski/mini.icons"),

  -- Treesitter
  gh("nvim-treesitter/nvim-treesitter"),
  gh("nvim-treesitter/nvim-treesitter-textobjects"),
  gh("windwp/nvim-ts-autotag"),
  gh("folke/ts-comments.nvim"),

  -- LSP
  gh("neovim/nvim-lspconfig"),
  gh("williamboman/mason.nvim"),
  gh("williamboman/mason-lspconfig.nvim"),
  gh("folke/lazydev.nvim"),

  -- Completion
  gh("saghen/blink.lib"),
  gh("saghen/blink.cmp"),
  gh("rafamadriz/friendly-snippets"),

  -- Formatting & Linting
  gh("stevearc/conform.nvim"),
  gh("mfussenegger/nvim-lint"),

  -- UI
  gh("EdenEast/nightfox.nvim"),
  gh("nvim-lualine/lualine.nvim"),
  gh("folke/noice.nvim"),
  gh("folke/snacks.nvim"),
  gh("folke/which-key.nvim"),
  gh("echasnovski/mini.ai"),
  gh("lewis6991/gitsigns.nvim"),
  gh("folke/todo-comments.nvim"),
  gh("folke/trouble.nvim"),
  gh("NvChad/nvim-colorizer.lua"),
  gh("folke/flash.nvim"),
  gh("MagicDuck/grug-far.nvim"),
  gh("akinsho/bufferline.nvim"),
  gh("folke/persistence.nvim"),

  -- Tools
  gh("epwalsh/obsidian.nvim"),
  gh("folke/sidekick.nvim"),
  gh("rhysd/vim-llvm"),
}, { confirm = false, load = true })

-- Build blink.cmp native fuzzy matcher on install/update
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    if ev.data.spec.name == "blink.cmp" and (ev.data.kind == "install" or ev.data.kind == "update") then
      require("blink.cmp.fuzzy.build").build()
    end
  end,
})
