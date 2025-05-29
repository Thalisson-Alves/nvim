return {
  'ruifm/gitlinker.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  keys = {
    { "<leader>gY", "<cmd>lua require'gitlinker'.get_buf_range_url('n')<cr>",                                                       desc = "Copy URL of the current line" },
    { "<leader>gY", "<cmd>lua require'gitlinker'.get_buf_range_url('v')<cr>",                                                       desc = "Copy URL of the selected lines", mode = "v" },
    { "<leader>gB", "<cmd>lua require'gitlinker'.get_repo_url({action_callback = require'gitlinker.actions'.open_in_browser})<cr>", desc = "Open Repo URL in Browser" },
  },
}
