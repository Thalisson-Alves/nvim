return {
  "olimorris/codecompanion.nvim",
  opts = {},
  dependencies = {
    { "nvim-lua/plenary.nvim", branch = "master" },
    "nvim-treesitter/nvim-treesitter",
    "hakonharnes/img-clip.nvim",
  },
  config = function()
    require("plugins.codecompanion.spinner"):init()
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
      },
      keymaps = {
        send = {
          callback = function(chat)
            vim.cmd("stopinsert")
            chat:send_message()
          end,
        },
      },
    })
  end,
  keys = {
    { "<leader>C", "<cmd>CodeCompanionChat Toggle<CR>", desc = "Toggle CodeCompanion Chat" },
  },
}
