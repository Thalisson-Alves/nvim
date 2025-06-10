local config = function()
  local telescope = require("telescope")
  telescope.setup({
    defaults = {
      path_display = { "smart" },
      mappings = {
        i = {
          ["<C-j>"] = "move_selection_next",
          ["<C-k>"] = "move_selection_previous",
        },
      },
    },
    pickers = {
      find_files = {
        theme = "dropdown",
        previewer = true,
        hidden = true,
      },
      live_grep = {
        theme = "dropdown",
        previewer = true,
      },
      buffers = {
        theme = "dropdown",
        previewer = true,
      },
    },
  })
  telescope.load_extension("ui-select")
  telescope.load_extension("git_file_history")
end

return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    {
      "isak102/telescope-git-file-history.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "tpope/vim-fugitive"
      }
    },
  },
  config = config,
  keys = {
    { "<leader>B",  "<cmd>Telescope buffers<cr>",                                                                                        desc = "Search buffers" },
    { "<leader>f",  "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>", desc = "Find files" },
    { "<leader>F",  "<cmd>Telescope live_grep<cr>",                                                                                      desc = "Find text" },
    { "<leader>go", "<cmd>Telescope git_status<cr>",                                                                                     desc = "Open changed file" },
    { "<leader>gb", "<cmd>Telescope git_branches<cr>",                                                                                   desc = "Checkout branch" },
    { "<leader>gc", "<cmd>Telescope git_commits<cr>",                                                                                    desc = "Checkout commit" },
    { "<leader>ld", "<cmd>Telescope diagnostics bufnr=0<cr>",                                                                            desc = "Document Diagnostics" },
    { "<leader>lw", "<cmd>Telescope diagnostics<cr>",                                                                                    desc = "Workspace Diagnostics" },
    { "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>",                                                                           desc = "Document Symbols" },
    { "<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",                                                                  desc = "Workspace Symbols" },
    { "<leader>sc", "<cmd>Telescope colorscheme<cr>",                                                                                    desc = "Colorscheme" },
    { "<leader>sh", "<cmd>Telescope help_tags<cr>",                                                                                      desc = "Find Help" },
    { "<leader>sM", "<cmd>Telescope man_pages<cr>",                                                                                      desc = "Man pages" },
    { "<leader>sr", "<cmd>Telescope oldfiles<cr>",                                                                                       desc = "Open Recent File" },
    { "<leader>sR", "<cmd>Telescope registers<cr>",                                                                                      desc = "Registers" },
    { "<leader>sk", "<cmd>Telescope keymaps<cr>",                                                                                        desc = "Keymaps" },
    { "<leader>sC", "<cmd>Telescope commands<cr>",                                                                                       desc = "Commands" },
    { "<leader>sg", "<cmd>Telescope git_file_history<cr>",                                                                               desc = "Git File History" },
  },
}
