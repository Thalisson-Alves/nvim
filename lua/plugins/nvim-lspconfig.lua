local on_attach = function(_, bufnr)
  local opts = { noremap = true, silent = true }
  local keymap = vim.api.nvim_buf_set_keymap
  keymap(bufnr, "n", "gd", "<cmd>Lspsaga goto_definition<CR>", opts)
  keymap(bufnr, "n", "gp", "<cmd>Lspsaga peek_definition<CR>", opts)
  keymap(bufnr, "n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
  keymap(bufnr, "n", "gr", "<cmd>Lspsaga finder<CR>", opts)
  keymap(bufnr, "n", "gl", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
  keymap(bufnr, "n", "<leader>lf", "<cmd>lua vim.lsp.buf.format{}<cr>", opts)
  keymap(bufnr, "n", "<leader>li", "<cmd>LspInfo<cr>", opts)
  keymap(bufnr, "n", "<leader>lI", "<cmd>LspInstallInfo<cr>", opts)
  keymap(bufnr, "n", "<leader>la", "<cmd>Lspsaga code_action<cr>", opts)
  keymap(bufnr, "n", "<leader>lj", "<cmd>Lspsaga diagnostic_jump_next<cr>", opts)
  keymap(bufnr, "n", "<leader>lk", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opts)
  keymap(bufnr, "n", "<leader>lr", "<cmd>Lspsaga rename<cr>", opts)
  keymap(bufnr, "n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  keymap(bufnr, "n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)

  -- if client.name == "pyright" then
  -- 	keymap(bufnr, "n", "<leader>oi", "PyrightOrganizeImports", "n", opts) -- organise imports
  -- 	keymap(bufnr, "n", "<leader>db", "DapToggleBreakpoint", "n", opts) -- toggle breakpoint
  -- 	keymap(bufnr, "n", "<leader>dr", "DapContinue", "n", opts) -- continue/invoke debugger
  -- 	keymap(bufnr, "n", "<leader>dt", "lua require('dap-python').test_method()", "n", opts) -- run tests
  -- end
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
    settings = { -- custom settings for lua
      Lua = {
        -- make the language server recognize "vim" global
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          -- make language server aware of runtime files
          library = {
            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
            [vim.fn.stdpath("config") .. "/lua"] = true,
          },
        },
      },
    },
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

  -- rust
  lspconfig.rust_analyzer.setup({
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

  -- C/C++
  lspconfig.clangd.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    cmd = {
      "clangd",
      "--offset-encoding=utf-16",
    },
  })

  local luacheck = require("efmls-configs.linters.luacheck")
  local stylua = require("efmls-configs.formatters.stylua")
  local flake8 = require("efmls-configs.linters.flake8")
  local black = require("efmls-configs.formatters.black")
  local eslint = require("efmls-configs.linters.eslint")
  local prettier_d = require("efmls-configs.formatters.prettier_d")
  local fixjson = require("efmls-configs.formatters.fixjson")
  local shellcheck = require("efmls-configs.linters.shellcheck")
  local shfmt = require("efmls-configs.formatters.shfmt")
  local hadolint = require("efmls-configs.linters.hadolint")
  local cpplint = require("efmls-configs.linters.cpplint")
  local clangformat = require("efmls-configs.formatters.clang_format")

  -- configure efm server
  lspconfig.efm.setup({
    filetypes = {
      "lua",
      "python",
      "json",
      "jsonc",
      "sh",
      "html",
      "css",
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "svelte",
      "vue",
      "markdown",
      "docker",
      "c",
      "cpp",
    },
    init_options = {
      documentFormatting = true,
      documentRangeFormatting = true,
      hover = true,
      documentSymbol = true,
      codeAction = true,
      completion = true,
    },
    settings = {
      languages = {
        lua = { luacheck, stylua },
        python = { flake8, black },
        typescript = { eslint, prettier_d },
        json = { eslint, fixjson },
        jsonc = { eslint, fixjson },
        sh = { shellcheck, shfmt },
        html = { prettier_d },
        css = { prettier_d },
        javascript = { eslint, prettier_d },
        javascriptreact = { eslint, prettier_d },
        typescriptreact = { eslint, prettier_d },
        svelte = { eslint, prettier_d },
        vue = { eslint, prettier_d },
        markdown = { prettier_d },
        docker = { hadolint, prettier_d },
        c = { clangformat, cpplint },
        cpp = { clangformat, cpplint },
      },
    },
  })
end

return {
  "neovim/nvim-lspconfig",
  config = config,
  lazy = false,
  dependencies = {
    "windwp/nvim-autopairs",
    "williamboman/mason.nvim",
    "creativenull/efmls-configs-nvim",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-nvim-lsp",
  },
}
