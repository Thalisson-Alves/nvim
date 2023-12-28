return {
  "glepnir/lspsaga.nvim",
  lazy = false,
  config = function()
    require("lspsaga").setup({
      finder = {
        keys = {
          -- use enter to open file with finder
          toggle_or_open = "<CR>",
          vsplit = "v",
          split = "s",
        },
      },
      -- use enter to open file with definition preview
      definition = {
        keys = {
          edit = "<CR>",
          vsplit = "<C-c>v",
          split = "<C-c>s",
        },
      },
    })
  end,
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
}
