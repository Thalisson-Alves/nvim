return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",         -- required
    "sindrets/diffview.nvim",        -- optional - Diff integration
    "nvim-telescope/telescope.nvim", -- optional
  },
  config = true,
  keys = {
    { "<leader>gg", "<cmd>Neogit cwd=%:p:h<CR>", desc = "Neogit current file" },
    { "<leader>gG", "<cmd>Neogit", desc = "Neogit cwd" },
  }
}
