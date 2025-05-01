return {
  "luckasRanarison/tailwind-tools.nvim",
  name = "tailwind-tools",
  build = ":UpdateRemotePlugins",
  ft = { "html", "css", "javascript", "typescript", "typescriptreact", "javascriptreact" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-telescope/telescope.nvim", -- optional
    "neovim/nvim-lspconfig",         -- optional
  },
  opts = {}                          -- your configuration
}
