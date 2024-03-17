local on_attach = function(_, bufnr)
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
local diagnostic_signs = { Error = "", Warn = "", Hint = "", Info = "" }

local config = function()
  require("neoconf").setup({})
  local cmp_nvim_lsp = require("cmp_nvim_lsp")
  local lspconfig = require("lspconfig")
  local capabilities = cmp_nvim_lsp.default_capabilities()

  for type, icon in pairs(diagnostic_signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
  end

  -- lua
  lspconfig.lua_ls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })

  -- json
  lspconfig.jsonls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = { "json", "jsonc" },
  })

  -- python
  lspconfig.pyright.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
      pyright = {
        disableOrganizeImports = false,
        analysis = {
          useLibraryCodeForTypes = true,
          autoSearchPaths = true,
          diagnosticMode = "workspace",
          autoImportCompletions = true,
          -- typeCheckingMode = "on",
        },
      },
    },
  })
  lspconfig.ruff_lsp.setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })

  -- rust
  lspconfig.rust_analyzer.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    checkOnSave = {
      command = "clippy",
    },
    cargo = {
      loadOutDirsFromCheck = true,
    },
    procMacro = {
      enable = true,
    },
    assist = {
      importMergeBehavior = "last",
      importPrefix = "by_self",
    },
    -- diagnostics = {
    -- 	disabled = { "unresolved-proc-macro" },
    -- },
    inlayHints = {
      chainingHints = true,
      typeHints = true,
      parameterHints = true,
      maxLength = 120,
    },
    hoverActions = {
      linksInHover = true,
    },
    lens = {
      methodReferences = true,
      references = true,
      implementations = true,
      run = true,
      debug = true,
    },
    cargoWatch = {
      enable = true,
      args = { "--all-targets" },
    },
    experimental = {
      procAttrMacros = true,
    },
  })

  -- typescript
  lspconfig.tsserver.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = {
      "typescript",
    },
    root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git"),
  })

  -- bash
  lspconfig.bashls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = { "sh", "aliasrc" },
  })

  -- typescriptreact, javascriptreact, css, sass, scss, less, svelte, vue
  lspconfig.emmet_ls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = {
      "typescriptreact",
      "javascriptreact",
      "javascript",
      "css",
      "sass",
      "scss",
      "less",
      "svelte",
      "vue",
      "html",
    },
  })

  -- docker
  lspconfig.dockerls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })
  lspconfig.docker_compose_language_service.setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })

  -- C/C++
  lspconfig.clangd.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    cmd = {
      "clangd",
      "--offset-encoding=utf-16",
    },
  })

  -- C#
  lspconfig.csharp_ls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })
end

return {
  "neovim/nvim-lspconfig",
  config = config,
  lazy = false,
  dependencies = {
    "williamboman/mason.nvim",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-nvim-lsp",
    { "folke/neodev.nvim", opts = {} },
  },
}
