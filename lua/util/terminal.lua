local M = setmetatable({}, {
  __call = function(m, ...)
    return m.open(...)
  end,
})

function M.open(opts)
  opts = opts or {}
  local cmd = opts.cmd or os.getenv("SHELL")
  local cwd = opts.cwd or vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":p:h")
  vim.cmd("Lspsaga term_toggle " .. cmd .. " " .. cwd)
  local term_opts = { nowait = true, silent = true }
  if opts.esc_esc == false then
    vim.api.nvim_buf_set_keymap(0, "t", "<esc>", "<esc>", term_opts)
  end
  if opts.ctrl_hjkl == false then
    vim.api.nvim_buf_set_keymap(0, "t", "<c-h>", "<c-h>", term_opts)
    vim.api.nvim_buf_set_keymap(0, "t", "<c-j>", "<c-j>", term_opts)
    vim.api.nvim_buf_set_keymap(0, "t", "<c-k>", "<c-k>", term_opts)
    vim.api.nvim_buf_set_keymap(0, "t", "<c-l>", "<c-l>", term_opts)
  end
end

return M
