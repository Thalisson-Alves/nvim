return {
  "olimorris/codecompanion.nvim",
  opts = {},
  dependencies = {
    { "nvim-lua/plenary.nvim", branch = "master" },
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    local adapter = require("plugins.codecompanion.adapter")
    require("codecompanion").setup({
      strategies = {
        chat = {
          slash_commands = adapter.get_slash_commands(),
          adapter = "copilot_compatible",
        },
        inline = {
          adapter = "copilot_compatible",
        },
      },
      adapters = {
        copilot_compatible = adapter.get_copilot_adapter,
      }
    })
  end,
  keys = {
    { "<leader>C", "<cmd>CodeCompanionChat Toggle<CR>", desc = "Toggle CodeCompanion" },
  },
}
