return {
	-- Tokyonight
	{ "folke/tokyonight.nvim", priority = 1000 },

	-- Gruvbox
	{ "ellisonleao/gruvbox.nvim", priority = 1000 },

	-- Catppuccin
	{ "catppuccin/nvim", name = "catppuccin", priority = 1000 },

	-- Kanagawa
	{ "rebelot/kanagawa.nvim", priority = 1000 },

	-- Nord
	{ "shaunsingh/nord.nvim", priority = 1000 },

	-- One Dark
	{ "navarasu/onedark.nvim", priority = 1000 },

	-- Dracula
	{ "Mofiqul/dracula.nvim", priority = 1000 },

	-- Everforest
	{ "sainnhe/everforest", priority = 1000 },

	-- PaperColor
	{ "NLKNguyen/papercolor-theme", priority = 1000 },

	-- Default theme loader
	{
		"LazyVim/LazyVim",
		config = function()
			vim.cmd("colorscheme dracula") -- change this to any installed theme
		end,
	},
}
