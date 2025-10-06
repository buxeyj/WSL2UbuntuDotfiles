return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim", -- manages formatters/linters
		"neovim/nvim-lspconfig",
	},
	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")

		mason.setup()

		-- LSP servers
		mason_lspconfig.setup({
			ensure_installed = {
				"clangd", -- C++
				"pyright", -- Python
				"lua_ls", -- Lua
			},
			automatic_installation = true,
		})

		-- Formatters & Linters
		mason_tool_installer.setup({
			ensure_installed = {
				-- Lua
				"stylua",
				-- C++
				"clangd",
			},
		})
	end,
}
