local config = function()
  local cmp = require("cmp")
  local luasnip = require("luasnip")
  local lspkind = require("lspkind")

  require("luasnip/loaders/from_vscode").lazy_load({ include = { "c", "cpp", "python" } })

  vim.opt.completeopt = "menu,menuone,noselect"

  -- configure custom snippets
  local custom_snips_opt = { base_dir = "~/prog/comp/Competitive-Programming/code", include_filetypes = { "cpp", "python" } }
  require("util.custom-snips").get_and_add_snips(custom_snips_opt)

  cmp.setup({
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
      ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
      ["<C-e>"] = cmp.mapping.abort(),        -- close completion window
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
    }),
    -- sources for autocompletion
    sources = cmp.config.sources({
      { name = "nvim_lsp" }, -- lsp
      { name = "luasnip" },  -- snippets
      { name = "buffer" },   -- text within current buffer
      { name = "path" },     -- file system paths
      { name = "crates" },   -- crates plugin
    }),
    -- configure lspkind for vs-code like icons
    formatting = {
      format = lspkind.cmp_format({
        maxwidth = 50,
        ellipsis_char = "...",
      }),
    },
  })
end
return {
  "hrsh7th/nvim-cmp",
  config = config,
  dependencies = {
    "onsails/lspkind.nvim",
    {
      "L3MON4D3/LuaSnip",
      -- follow latest release.
      version = "2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
      -- install jsregexp (optional!).
      build = "make install_jsregexp",
    },
  },
}
