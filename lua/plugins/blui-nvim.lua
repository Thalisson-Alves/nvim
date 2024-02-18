return {
  -- "Thalisson-Alves/blui-nvim",
  dir = "~/prog/nvim-plugins/blui-nvim",
  dependencies = {
    "akinsho/bufferline.nvim",
    "nvim-lua/plenary.nvim",
  },
  opts = {
    close_command = "Bdelete %d",
  },
  keys = {
    { "<leader>b", "<cmd>lua require('blui.ui').toggle_window()<cr>", desc = "Buffers" },
  },
}
