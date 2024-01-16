local M = setmetatable({}, {
  __call = function(m, ...)
    return m.open(...)
  end,
})

local terminals = {}

function M.open(opts)
  opts = vim.tbl_deep_extend("force", {
    cmd = vim.o.shell,
    cwd = vim.fn.getcwd(),
    esc_esc = true,
    ctrl_hjkl = true,
    ft = "terminal",
    size = { width = 0.9, height = 0.9 },
    border = "rounded",
  }, opts or {}, { persistent = true })

  local key = vim.inspect({ cmd = opts.cmd, count = vim.v.count1 })
  if terminals[key] and terminals[key]:buf_valid() then
    terminals[key]:toggle()
  else
    terminals[key] = require("lazy.util").float_term(opts.cmd, opts)
    local buf = terminals[key].buf
    vim.b[buf].lazyterm_cmd = opts.cmd
    local term_opts = { nowait = true, silent = true }
    if opts.esc_esc == false then
      vim.api.nvim_buf_set_keymap(buf, "t", "<esc>", "<esc>", term_opts)
    end
    if opts.ctrl_hjkl == false then
      vim.api.nvim_buf_set_keymap(buf, "t", "<c-h>", "<c-h>", term_opts)
      vim.api.nvim_buf_set_keymap(buf, "t", "<c-j>", "<c-j>", term_opts)
      vim.api.nvim_buf_set_keymap(buf, "t", "<c-k>", "<c-k>", term_opts)
      vim.api.nvim_buf_set_keymap(buf, "t", "<c-l>", "<c-l>", term_opts)
    end

    vim.api.nvim_create_autocmd("BufEnter", {
      buffer = buf,
      callback = function()
        vim.cmd.startinsert()
      end,
    })
  end

  return terminals[key]
end

return M
