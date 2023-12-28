local opts = {
	ensure_installed = {
		"efm",
    "rust_analyzer",
		"clangd",
		"bashls",
		"pyright",
		"lua_ls",
		"jsonls",
		-- "tsserver",
		-- "tailwindcss",
	},

	automatic_installation = true,
}

return {
	"williamboman/mason-lspconfig.nvim",
	opts = opts,
	event = "BufReadPre",
	dependencies = "williamboman/mason.nvim",
}
