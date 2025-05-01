local opts = {
  ensure_installed = {
    "clangd",
    "bashls",
    "pyright",
    "ruff",
    "lua_ls",
    "jsonls",
    "dockerls",
    "docker_compose_language_service",
  },

  automatic_installation = true,
}

return {
  "williamboman/mason-lspconfig.nvim",
  opts = opts,
  event = "BufReadPre",
  dependencies = "williamboman/mason.nvim",
}
