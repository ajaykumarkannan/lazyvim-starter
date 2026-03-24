-- Override blink.cmp keymap: use Tab to accept completions instead of Enter
-- Only show completion menu when Tab is pressed, not on every keystroke.
return {
  {
    "saghen/blink.cmp",
    opts = {
      completion = {
        list = { selection = { preselect = false, auto_insert = false } },
        menu = { auto_show = false },
      },
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
