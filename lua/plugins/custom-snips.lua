local ft = { "cpp", "python" }

return {
  "Thalisson-Alves/snips-nvim",
  ft = ft,
  dependencies = {
    "L3MON4D3/LuaSnip",
  },
  opts = {
    base_dir = "~/prog/comp/Competitive-Programming/code",
    include_filetypes = ft,
  },
}
