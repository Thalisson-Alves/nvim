return {
  "nvim-neotest/neotest",
  lazy = false,
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",

    -- language specific
    { "mrcjkb/rustaceanvim" }
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("rustaceanvim.neotest"),
      }
    })
  end,
  keys = {
    { "<leader>Tt", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>", desc = "Test file" },
    { "<leader>Tl", "<cmd>lua require('neotest').run.run_last()<CR>",              desc = "Test last" },
    { "<leader>Tf", "<cmd>lua require('neotest').run.run()<CR>",                   desc = "Test function" },
    { "<leader>Ts", "<cmd>lua require('neotest').run.stop()<CR>",                  desc = "Test stop" },
    { "<leader>To", "<cmd>lua require('neotest').output.open({ enter = true })<CR>", desc = "Test open output" },
  },
}
