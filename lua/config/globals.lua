vim.g.mapleader = " "
vim.g.maplocalleader = " "

function _GOTO_FILE(filepath)
  filepath = filepath or vim.fn.expand("%")
  vim.api.nvim_set_current_dir(vim.fn.fnamemodify(filepath, ':h:p'))
  vim.cmd('e ' .. filepath)
end
