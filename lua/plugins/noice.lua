return {
  "folke/noice.nvim",
  opts = {
    cmdline = {
      view = "cmdline", -- Traditional cmdline at the bottom
    },
    views = {
      cmdline_popup = {
        position = {
          row = "50%", -- This handles cases where it might still try to float
          col = "50%",
        },
      },
    },
  },
}
