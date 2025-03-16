return {
  "saecki/crates.nvim",
  tag = "stable",
  event = { "BufRead Cargo.toml" },
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    lsp = {
      enabled = true,
      on_attach = require("config.lsp").on_attach,
      actions = true,
      completion = true,
      hover = true,
    },
    completion = {
      cmp = { enabled = true },
    },
  },
}
