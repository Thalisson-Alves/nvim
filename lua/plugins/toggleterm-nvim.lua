return {
  "akinsho/toggleterm.nvim",
  commit = "16a2873e674b17b67a399db657c359e0a0c906ff",
  opts = {
    size = 20,
    open_mapping = [[<c-\>]],
    hide_numbers = true,
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    insert_mappings = true,
    persist_size = true,
    direction = "horizontal",
    close_on_exit = true,
    shell = vim.o.shell,
    float_opts = {
      border = "curved",
      -- winblend = 30,
      highlights = {
        border = "Normal",
        background = "Normal",
      },
    },
    on_open = function()
      vim.cmd("startinsert!")
    end,
  },
  config = function(_, opts)
    require("toggleterm").setup(opts)

    local python = require("toggleterm.terminal").Terminal:new({
      cmd = "python3",
      hidden = true,
    })

    function _PYTHON_TOGGLE()
      python:toggle()
    end
  end,
  keys = {
    [[<c-\>]],
    { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>",            desc = "Float" },
    { "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>",       desc = "Horizontal" },
    { "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", desc = "Vertical" },
    { "<leader>tp", "<cmd>lua _PYTHON_TOGGLE()<cr>",                  desc = "Python" },
  }
}
