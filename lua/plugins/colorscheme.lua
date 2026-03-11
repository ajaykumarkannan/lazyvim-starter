return {
  -- Add the colorscheme plugin
  {
    "EdenEast/nightfox.nvim",
    priority = 1000,
    config = function()
      require("nightfox").setup({
        palettes = {
          carbonfox = {
            -- Soften the default fg (#f2f4f8) to reduce contrast
            -- Using fg2 level brightness (~24 steps darker than fg1)
            fg1 = "#c8c8cb",
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
