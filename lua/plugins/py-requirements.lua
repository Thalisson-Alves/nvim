return {
  'MeanderingProgrammer/py-requirements.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  event = { 'BufReadPre requirements.txt' },
  config = function()
    require('py-requirements').setup({})
  end,
}
