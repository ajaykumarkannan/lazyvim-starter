local gh = function(repo)
  return "https://github.com/" .. repo
end

vim.pack.add({
  -- Dependencies (load before dependents)
  gh("nvim-lua/plenary.nvim"), -- async utilities and common lua functions used by many plugins
  gh("MunifTanjim/nui.nvim"), -- UI component library for plugin authors
  gh("echasnovski/mini.icons"), -- file/symbol icon provider

  -- Treesitter
  gh("nvim-treesitter/nvim-treesitter"), -- incremental parsing for syntax highlighting, folding, indentation
  gh("nvim-treesitter/nvim-treesitter-textobjects"), -- select/move/swap code by syntax (functions, classes, args)
  gh("windwp/nvim-ts-autotag"), -- auto-close and rename HTML/JSX tags
  gh("folke/ts-comments.nvim"), -- context-aware comment strings using treesitter

  -- LSP
  gh("neovim/nvim-lspconfig"), -- configurations for built-in LSP client
  gh("williamboman/mason.nvim"), -- portable installer for LSP servers, formatters, linters
  gh("williamboman/mason-lspconfig.nvim"), -- bridges mason and lspconfig for auto-setup
  gh("folke/lazydev.nvim"), -- workspace library setup for editing neovim lua configs

  -- Completion
  gh("saghen/blink.lib"), -- runtime library for blink.cmp
  gh("saghen/blink.cmp"), -- fast completion engine with fuzzy matching
  gh("rafamadriz/friendly-snippets"), -- collection of premade snippets for many languages

  -- Formatting & Linting
  gh("stevearc/conform.nvim"), -- format on save using external formatters (prettier, stylua, etc.)
  gh("mfussenegger/nvim-lint"), -- async linting with external tools (eslint, shellcheck, etc.)

  -- UI
  gh("EdenEast/nightfox.nvim"), -- colorscheme
  gh("nvim-lualine/lualine.nvim"), -- statusline
  gh("folke/noice.nvim"), -- replaces command line, messages, and popups with floating UI
  gh("folke/snacks.nvim"), -- utility bundle: fuzzy picker, file explorer, notifications
  gh("folke/which-key.nvim"), -- shows available keybindings in a popup after pressing a prefix
  gh("echasnovski/mini.ai"), -- extended text objects (around/inside quotes, brackets, arguments)
  gh("lewis6991/gitsigns.nvim"), -- git change indicators in the sign column, inline blame
  gh("folke/todo-comments.nvim"), -- highlights and searches TODO/FIXME/HACK comments
  gh("folke/trouble.nvim"), -- pretty list for diagnostics, references, quickfix
  gh("NvChad/nvim-colorizer.lua"), -- inline color previews for hex/rgb values
  gh("folke/flash.nvim"), -- jump anywhere on screen with minimal keystrokes
  gh("MagicDuck/grug-far.nvim"), -- find and replace across files
  gh("akinsho/bufferline.nvim"), -- tab bar showing open buffers
  gh("folke/persistence.nvim"), -- auto-saves and restores sessions (open buffers, layout)

  -- Tools
  gh("obsidian-nvim/obsidian.nvim"), -- Obsidian vault integration: links, notes, daily notes
  gh("folke/sidekick.nvim"), -- embedded AI CLI panel (Claude, etc.)
  gh("rhysd/vim-llvm"), -- syntax highlighting for LLVM IR, tablegen, .mir files
}, { confirm = false, load = true })

-- Build blink.cmp native fuzzy matcher on install/update
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    if ev.data.spec.name == "blink.cmp" and (ev.data.kind == "install" or ev.data.kind == "update") then
      require("blink.cmp.fuzzy.build").build()
    end
  end,
})
