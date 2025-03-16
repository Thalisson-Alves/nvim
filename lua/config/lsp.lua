local M = {}

M.on_attach = function(_, bufnr)
  local opts = { noremap = true, silent = true }
  local function map(mode, lhs, rhs, opt)
    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, vim.tbl_deep_extend("keep", opt, opts))
  end
  map("n", "gd", "<cmd>Lspsaga goto_definition<CR>", { desc = "Go to definition" })
  map("n", "gp", "<cmd>Lspsaga peek_definition<CR>", { desc = "Peek definition" })
  map("n", "K", "<cmd>Lspsaga hover_doc<CR>", { desc = "Hover doc" })
  map("n", "gr", "<cmd>Lspsaga finder<CR>", { desc = "References" })
  map("n", "gl", "<cmd>Lspsaga show_line_diagnostics<CR>", { desc = "Line diagnostics" })
  map("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format{}<cr>", { desc = "Format" })
  map("v", "<leader>lf",
    "<cmd>lua vim.lsp.buf.format{range={['start']=vim.api.nvim_buf_get_mark(0,'<'),['end']=vim.api.nvim_buf_get_mark(0,'>')}}<cr>",
    { desc = "Format" })
  map("n", "<leader>la", "<cmd>Lspsaga code_action<cr>", { desc = "Code action" })
  map("n", "<leader>lj", "<cmd>Lspsaga diagnostic_jump_next<cr>", { desc = "Next diagnostic" })
  map("n", "<leader>lk", "<cmd>Lspsaga diagnostic_jump_prev<cr>", { desc = "Prev diagnostic" })
  map("n", "<leader>lr", "<cmd>Lspsaga rename<cr>", { desc = "Rename" })
  map("n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", { desc = "Signature help" })
  map("n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", { desc = "Quickfix" })
end

return M
