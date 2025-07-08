return {
  "mrcjkb/rustaceanvim",
  version = "^6", -- Recommended
  lazy = false,   -- This plugin is already lazy
  config = function()
    vim.g.rustaceanvim = {
      server = {
        on_attach = require("config.lsp").on_attach,
      },
    }
  end,
}
