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
			-- 🌙 Set your preferred theme here
			vim.cmd("colorscheme kanagawa")

			-- 🔒 Disable all italics globally (for every theme)
			vim.api.nvim_create_autocmd("ColorScheme", {
				pattern = "*",
				callback = function()
					vim.cmd([[
            highlight Comment cterm=NONE gui=NONE
            highlight Keyword cterm=NONE gui=NONE
            highlight Function cterm=NONE gui=NONE
            highlight Type cterm=NONE gui=NONE
            highlight Statement cterm=NONE gui=NONE
            highlight Identifier cterm=NONE gui=NONE
          ]])
				end,
			})
		end,
	},
}
