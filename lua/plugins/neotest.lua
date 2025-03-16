return {
  "nvim-neotest/neotest",
  lazy = false,
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",

    -- language specific
    { "mrcjkb/rustaceanvim", version = "^5" }
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("rustaceanvim.neotest"),
      }
    })
  end,
  keys = {
    { "<leader>dtt", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>", desc = "Test file" },
    { "<leader>dtl", "<cmd>lua require('neotest').run.run_last()<CR>",              desc = "Test last" },
    { "<leader>dtf", "<cmd>lua require('neotest').run.run()<CR>",                   desc = "Test function" },
    { "<leader>dts", "<cmd>lua require('neotest').run.stop()<CR>",                  desc = "Test stop" },
    { "<leader>dto", "<cmd>lua require('neotest').output.open({ enter = true })<CR>", desc = "Test open output" },
  },
}
