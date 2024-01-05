return {
  "saecki/crates.nvim",
  tag = "stable",
  event = { "BufRead Cargo.toml" },
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    src = {
      cmp = { enabled = true },
    },
  },
}
