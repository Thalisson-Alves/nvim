return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    update_focused_file = {
      enable = true,
      update_root = true,
    },
    diagnostics = {
      enable = true,
      show_on_dirs = true,
    },
    renderer = {
      root_folder_label = function(path)
        return vim.fn.substitute(
          vim.fn.fnamemodify(path, ":~"),
          [[.*/\(\([^/]\+/\)\{1\}.*\)]], [[\1]], ""
        )
      end
    },
    on_attach = function(bufnr)
      local api = require("nvim-tree.api")

      local function opts(desc)
        return {
          desc = 'nvim-tree: ' .. desc,
          buffer = bufnr,
          noremap = true,
          silent = true,
          nowait = true,
        }
      end

      api.config.mappings.default_on_attach(bufnr)

      local function map(mode, key, cmd, desc)
        vim.keymap.set(mode, key, cmd, opts(desc))
      end

      map("n", "l", api.node.open.edit, "Edit")
      map("n", "h", api.node.navigate.parent_close, "Close Directory")
      map("n", "?", api.tree.toggle_help, "Help")
    end,
  },
  init = function()
    if vim.fn.argc(-1) == 1 then
      local stat = vim.loop.fs_stat(vim.fn.argv(0))
      if stat and stat.type == "directory" then
        require("nvim-tree")
      end
    end
  end,
  config = function(_, opts)
    require("nvim-tree").setup(opts)
  end,
  keys = {
    { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "File Tree" },
  },
}
