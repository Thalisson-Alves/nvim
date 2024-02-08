local config = function()
  local wk = require("which-key")

  local mappings = {
    w = { "<cmd>w!<cr>", "Save" },
    W = { "<cmd>noa w!<cr>", "Save no autocommands" },
    q = { "<cmd>q!<cr>", "Quit" },
    c = { "<cmd>bp<bar>sp<bar>bn<bar>bd!<cr>", "Close buffer" },
    h = { "<cmd>nohlsearch<CR>", "No Highlight" },
    L = { "<cmd> Lazy<cr>", "Lazy" },
    g = { name = "+Git" },
    l = {
      name = "+LSP",
      i = { "<cmd>LspInfo<cr>", "Lsp info" },
    },
    s = { name = "+Search" },
    t = { name = "+Terminal" },
    v = { name = "+PyVenv" },
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
