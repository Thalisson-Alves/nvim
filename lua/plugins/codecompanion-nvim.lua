return {
  "olimorris/codecompanion.nvim",
  opts = {},
  dependencies = {
    { "nvim-lua/plenary.nvim", branch = "master" },
    "nvim-treesitter/nvim-treesitter",
    {
      "HakonHarnes/img-clip.nvim",
      opts = {
        default = {
          dir_path = "/tmp/img-clip",
        },
        filetypes = {
          codecompanion = {
            prompt_for_file_name = false,
            template = "[Image]($FILE_PATH)",
            use_absolute_path = true,
          },
        },
      },
    },
  },
  config = function()
    require("plugins.codecompanion.spinner"):init()
    require("codecompanion").setup({
      strategies = {
        chat = {
          adapter = "copilot",
        },
        inline = {
          adapter = "copilot",
        },
        cmd = {
          adapter = "copilot",
        },
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
