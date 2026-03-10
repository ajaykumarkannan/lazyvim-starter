return {
  -- Add the colorscheme plugin
  {
    "EdenEast/nightfox.nvim",
    priority = 1000,
    config = function()
      require("nightfox").setup({
        palettes = {
          carbonfox = {
            fg1 = "#c8cacc", -- softer foreground (default is #f2f4f8)
          },
        },
        options = {
          styles = {
            comments = "italic",
          },
        },
      })
    end,
  },
  -- Configure LazyVim to use it
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "carbonfox",
    },
  },
}
