local config = function()
  local wk = require("which-key")

  local mappings = {
    ["a"] = { "<cmd>Alpha<cr>", "Alpha" },
    ["b"] = {
      "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
      "Buffers",
    },
    ["e"] = { "<cmd>lua require('neo-tree.command').execute({ toggle = true })<cr>", "Explorer" },
    ["w"] = { "<cmd>w!<cr>", "Save" },
    ["q"] = { "<cmd>q!<cr>", "Quit" },
    ["c"] = { "<cmd>bdelete!<cr>", "Close buffer" },
    ["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
    ["f"] = {
      "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
      "Find files",
    },
    ["F"] = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },

    L = {
      name = "Lazy",
      h = { "<cmd>Lazy home<cr>", "Home" },
      i = { "<cmd>Lazy install<cr>", "Install" },
      s = { "<cmd>Lazy sync<cr>", "Sync" },
      u = { "<cmd>Lazy update<cr>", "Update" },
      c = { "<cmd>Lazy check<cr>", "Check" },
    },

    g = {
      name = "Git",
      g = { "<cmd>lua require('util.terminal')({ cmd = 'gitui', esc_esc = false, ctrl_hjkl = false })<CR>", "GitUI" },
      j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
      k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
      l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
      p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
      r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
      R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
      s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
      u = {
        "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
        "Undo Stage Hunk",
      },
      o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
      b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
      c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
      d = { "<cmd>Gitsigns diffthis HEAD<cr>", "Diff" },
    },

    l = {
      name = "LSP",
      a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
      d = {
        "<cmd>Telescope diagnostics bufnr=0<cr>",
        "Document Diagnostics",
      },
      w = {
        "<cmd>Telescope diagnostics<cr>",
        "Workspace Diagnostics",
      },
      f = { "<cmd>lua vim.lsp.buf.format{async=true}<cr>", "Format" },
      i = { "<cmd>LspInfo<cr>", "Info" },
      j = {
        "<cmd>Lspsaga diagnostic_jump_prev<cr>",
        "Next Diagnostic",
      },
      k = {
        "<cmd>Lspsaga diagnostic_jump_next<cr>",
        "Prev Diagnostic",
      },
      l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
      q = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix" },
      r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
      s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
      S = {
        "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
        "Workspace Symbols",
      },
    },
    s = {
      name = "Search",
      b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
      c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
      h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
      M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
      r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
      R = { "<cmd>Telescope registers<cr>", "Registers" },
      k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
      C = { "<cmd>Telescope commands<cr>", "Commands" },
    },

    t = {
      name = "Terminal",
      n = { "<cmd>Lspsaga term_toggle node<cr>", "Node" },
      t = { "<cmd>Lspsaga term_toggle htop<cr>", "Htop" },
      p = { "<cmd>Lspsaga term_toggle python3<cr>", "Python" },
      f = { "<cmd>Lspsaga term_toggle<cr>", "Float" },
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
