-- Override blink.cmp keymap: use Tab to accept completions instead of Enter
return {
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        -- Switch from "enter" to "super-tab" preset:
        -- Tab accepts completion (or snippet forward / AI accept / fallback)
        -- Enter just inserts a newline (no completion accept)
        preset = "super-tab",
        ["<CR>"] = {},
      },
    },
  },
}
