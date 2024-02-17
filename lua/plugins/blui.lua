return {
  "Thalisson-Alves/blui-nvim",
  dependencies = {
    "akinsho/bufferline.nvim",
    "nvim-lua/plenary.nvim",
  },
  keys = {
    { "<leader>b", "<cmd>lua require('blui.ui').toggle_window()<cr>", desc = "Buffers" },
  },
}
