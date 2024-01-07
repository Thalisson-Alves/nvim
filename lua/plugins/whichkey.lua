local config = function()
  local wk = require("which-key")

  local mappings = {
    w = { "<cmd>w!<cr>", "Save" },
    q = { "<cmd>q!<cr>", "Quit" },
    c = { "<cmd>bdelete!<cr>", "Close buffer" },
    h = { "<cmd>nohlsearch<CR>", "No Highlight" },
    L = { "<cmd> Lazy<cr>", "Lazy" },
    g = { name = "+Git" },
    l = { name = "+LSP" },
    s = { name = "+Search" },
    t = {
      name = "+Terminal",
      t = { "<cmd>lua require('util.terminal')({ cmd = 'htop' })<cr>", "Htop" },
      p = { "<cmd>lua require('util.terminal')({ cmd = 'python3' })<cr>", "Python" },
      f = { "<cmd>lua require('util.terminal')()<cr>", "Float" },
    },
  }
  local opts = {
    mode = "n",     -- NORMAL mode
    prefix = "<leader>",
    buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true,  -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true,  -- use `nowait` when creating keymaps
    expr = false,   -- use `expr` when creating keymaps
  }
  wk.register(mappings, opts)
end

return {
  "folke/which-key.nvim",
  lazy = false,
  opts = {},
  config = config,
}
