local diagnostic_signs = { Error = "", Warn = "", Hint = "", Info = "" }

local config = function()
  require("neoconf").setup({})
  local cmp_nvim_lsp = require("cmp_nvim_lsp")
  local lspconfig = require("lspconfig")
  local capabilities = cmp_nvim_lsp.default_capabilities()
  local on_attach = require("config.lsp").on_attach

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
  lspconfig.ruff.setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })

  -- typescript
  lspconfig.ts_ls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    commands = {
      TypeScriptOrganizeImports = {
        function()
          vim.lsp.buf.execute_command({
            command = "_typescript.organizeImports",
            arguments = { vim.api.nvim_buf_get_name(0) },
          })
        end,
        description = "Organize Imports",
      },
    },
  })

  -- bash
  lspconfig.bashls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = { "sh", "aliasrc" },
  })

  -- HTML
  lspconfig.html.setup({
    capabilities = capabilities,
    on_attach = on_attach,
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
    init_options = {
      fallbackFlags = {
        "-I", vim.fn.getcwd() .. "/src",
      },
    },
  })

  -- C#
  lspconfig.csharp_ls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
  })

  -- Go
  lspconfig.gopls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    root_dir = lspconfig.util.root_pattern("go.work", "go.mod", ".git"),
    settings = {
      gopls = {
        completeUnimported = true,
        usePlaceholders = true,
        analyses = {
          unusedparams = true,
        },
      },
    },
  })

  -- Latex
  -- lspconfig.texlab.setup({
  --   capabilities = capabilities,
  --   on_attach = on_attach,
  -- })

  -- Java
  -- lspconfig.jdtls.setup({
  --   capabilities = capabilities,
  --   on_attach = on_attach,
  --   cmd = {
  --     'java',
  --     '-Declipse.application=org.eclipse.jdt.ls.core.id1',
  --     '-Dosgi.bundles.defaultStartLevel=4',
  --     '-Declipse.product=org.eclipse.jdt.ls.core.product',
  --     '-Dlog.protocol=true',
  --     '-Dlog.level=ALL',
  --     '-Xmx1g',
  --     '--add-modules=ALL-SYSTEM',
  --     '--add-opens',
  --     'java.base/java.util=ALL-UNNAMED',
  --     '--add-opens',
  --     'java.base/java.lang=ALL-UNNAMED',
  --     '-javaagent:' .. os.getenv('HOME') .. '/.local/share/nvim/mason/packages/jdtls/lombok.jar',
  --     '-jar',
  --     vim.fn.glob(os.getenv('HOME') ..
  --       '/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar'),
  --     '-configuration',
  --     os.getenv('HOME') .. '/.local/share/nvim/mason/packages/jdtls/config_linux',
  --     '-data',
  --     os.getenv('HOME') .. '/.local/share/nvim/mason/packages/jdtls/workspace',
  --   },
  --   root_dir = lspconfig.util.root_pattern("pom.xml", "gradle.build", ".git", "mvnw", "gradlew"),
  --   settings = {
  --     java = {
  --       signatureHelp = { enabled = true },
  --       maven = {
  --         downloadSources = true,
  --       },
  --       referencesCodeLens = {
  --         enabled = true,
  --       },
  --       references = {
  --         includeDecompiledSources = true,
  --       },
  --       inlayHints = {
  --         parameterNames = {
  --           enabled = 'all', -- literals, all, none
  --         },
  --       },
  --       format = {
  --         enabled = false,
  --       },
  --     },
  --   },
  --   init_options = {
  --     -- TODO: configure vscode-java-test
  --     -- bundles = {
  --     --   vim.fn.glob(""),
  --     -- },
  --   },
  -- })
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
  },
}
