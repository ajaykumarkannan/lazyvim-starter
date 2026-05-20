require("sidekick").setup({
  cli = {
    mux = {
      backend = "tmux",
      enabled = true,
    },
    tools = {
      kiro = {
        cmd = { "kiro-cli" },
      },
      opencode = {
        cmd = { "opencode" },
        env = { OPENCODE_THEME = "system" },
      },
    },
  },
})
