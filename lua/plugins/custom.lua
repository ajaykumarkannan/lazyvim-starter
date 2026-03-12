-- Custom plugins migrated from .vimrc
return {
  -- Remove time/clock from the status bar
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.sections = opts.sections or {}
      -- Shorten mode names to single letters
      opts.sections.lualine_a = {
        {
          "mode",
          fmt = function(str)
            return str:sub(1, 1)
          end,
        },
      }
      -- Remove time/clock
      opts.sections.lualine_z = {}
    end,
  },

  -- LLVM and TableGen syntax highlighting
  {
    "rhysd/vim-llvm",
    ft = { "llvm", "tablegen" },
  },

  -- Strip trailing whitespace on save
  -- Using autocmd since conform.nvim handles formatting
  {
    "LazyVim/LazyVim",
    opts = function()
      -- Set up LLVM/TableGen file types
      vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
        pattern = "*.ll",
        callback = function()
          vim.bo.filetype = "llvm"
        end,
      })
      vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
        pattern = "*.td",
        callback = function()
          vim.bo.filetype = "tablegen"
        end,
      })

      -- Strip trailing whitespace on save (for all files)
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*",
        callback = function()
          -- Save cursor position
          local cursor = vim.api.nvim_win_get_cursor(0)
          -- Remove trailing whitespace
          vim.cmd([[%s/\s\+$//e]])
          -- Restore cursor position
          pcall(vim.api.nvim_win_set_cursor, 0, cursor)
        end,
      })
    end,
  },
}
