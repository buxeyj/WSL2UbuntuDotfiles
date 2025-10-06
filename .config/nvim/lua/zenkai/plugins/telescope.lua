return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
	},

	config = function()
		-- 🧩 Fix PATH for WSL2 so fd & rg are detected correctly
		vim.env.PATH = vim.env.PATH .. ":/usr/local/bin:/usr/bin:" .. vim.fn.expand("~/.local/bin")

		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local builtin = require("telescope.builtin")

		telescope.setup({
			defaults = {
				prompt_prefix = "  ",
				selection_caret = "  ",
				path_display = { "smart" },
				layout_config = { width = 0.9 },
				mappings = {
					i = {
						["<C-h>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
						["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
						["<Esc>"] = actions.close,
					},
				},

				-- Use ripgrep for text search
				vimgrep_arguments = {
					"rg",
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
					"--smart-case",
					"--hidden",
					"--no-ignore",
					"--glob",
					"!.git/*",
				},
			},

			pickers = {
				find_files = {
					hidden = true,
					find_command = { "fd", "--type", "f", "--hidden", "--follow", "--exclude", ".git" },
				},
				live_grep = {
					additional_args = function(_)
						return { "--hidden", "--no-ignore", "--glob", "!.git/*" }
					end,
				},
			},
		})

		telescope.load_extension("fzf")

		-- 🔑 Keymaps (load after Telescope exists)
		local keymap = vim.keymap

		-- <leader>ff → Find files (includes hidden + ignores .git)
		keymap.set("n", "<leader>ff", function()
			builtin.find_files({
				cwd = vim.loop.cwd(), -- search from current working directory
				hidden = true,
				find_command = { "fd", "--type", "f", "--hidden", "--follow", "--exclude", ".git" },
			})
		end, { desc = "Find Files (current folder + hidden)" })

		-- <leader>fs → Live Grep (search text recursively in current folder)
		keymap.set("n", "<leader>fs", function()
			builtin.live_grep({
				cwd = vim.loop.cwd(), -- search from current folder
				additional_args = function(_)
					return { "--hidden", "--no-ignore", "--glob", "!.git/*" }
				end,
			})
		end, { desc = "Live Grep (search entire current folder)" })
	end,
}
