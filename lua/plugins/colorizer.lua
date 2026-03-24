return {
  {
    "NvChad/nvim-colorizer.lua",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      filetypes = { "css", "scss", "html", "javascript", "typescript", "lua" },
      user_default_options = {
        css = true,
        names = false,
        tailwind = false,
        mode = "background", -- "background" or "foreground" or "virtualtext"
      },
    },
  },
}
