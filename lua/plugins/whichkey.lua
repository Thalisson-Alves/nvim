return {
  "folke/which-key.nvim",
  lazy = false,
  opts = {},
  keys = {
    { "<leader>L",  "<cmd> Lazy<cr>",      desc = "Lazy",                 expr = false,  nowait = true, remap = false },
    { "<leader>W",  "<cmd>noa w!<cr>",     desc = "Save no autocommands", expr = false,  nowait = true, remap = false },
    { "<leader>c",  "<cmd>Bdelete<cr>",    desc = "Close buffer",         expr = false,  nowait = true, remap = false },
    { "<leader>d",  expr = false,          group = "DAP",                 nowait = true, remap = false },
    { "<leader>g",  expr = false,          group = "Git",                 nowait = true, remap = false },
    { "<leader>h",  "<cmd>nohlsearch<CR>", desc = "No Highlight",         expr = false,  nowait = true, remap = false },
    { "<leader>l",  expr = false,          group = "LSP",                 nowait = true, remap = false },
    { "<leader>li", "<cmd>LspInfo<cr>",    desc = "Lsp info",             expr = false,  nowait = true, remap = false },
    { "<leader>q",  "<cmd>q!<cr>",         desc = "Quit",                 expr = false,  nowait = true, remap = false },
    { "<leader>s",  expr = false,          group = "Search",              nowait = true, remap = false },
    { "<leader>t",  expr = false,          group = "Terminal",            nowait = true, remap = false },
    { "<leader>v",  expr = false,          group = "PyVenv",              nowait = true, remap = false },
    { "<leader>w",  "<cmd>w!<cr>",         desc = "Save",                 expr = false,  nowait = true, remap = false },
  }
}
