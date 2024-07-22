return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",         -- required
    "sindrets/diffview.nvim",        -- optional - Diff integration
    "nvim-telescope/telescope.nvim", -- optional
    "ibhagwan/fzf-lua",              -- optional
  },
  tag = "v1.0.0",
  config = true,
  keys = {
    { "<leader>gg", "<cmd>Neogit cwd=%:p:h<cr>", desc = "Neogit current file" },
    { "<leader>gG", "<cmd>Neogit<cr>",           desc = "Neogit cwd" },
  }
}
