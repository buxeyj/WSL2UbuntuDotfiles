-- Set leader key
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps
---------------------

-- use jk to exit insert mode
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

-- Move between splits with Ctrl + hjkl
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left split" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right split" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to below split" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to above split" })

-- Resize splits with Ctrl + Arrow keys
keymap.set("n", "<C-Up>", ":resize +2<CR>", { silent = true, desc = "Resize split shorter" })
keymap.set("n", "<C-Down>", ":resize -2<CR>", { silent = true, desc = "Resize split taller" })
keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", { silent = true, desc = "Resize split narrower" })
keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", { silent = true, desc = "Resize split wider" })

---------------------
-- Run Current File
---------------------
keymap.set("n", "<leader>r", function()
	-- Save the file first
	vim.cmd("write")

	-- Detect filetype and run
	local ft = vim.bo.filetype
	if ft == "cpp" then
		vim.cmd("split | terminal g++ % -o %:r && ./%:r")
	elseif ft == "python" then
		vim.cmd("split | terminal python3 %")
	elseif ft == "lua" then
		vim.cmd("split | terminal lua %")
	else
		print("No run command for filetype: " .. ft)
	end
end, { desc = "Save and run current file" })

---------------------
-- Telescope Keymaps (Fixed)
---------------------

-- <leader>ff → Find files (includes hidden + ignores .git)
vim.keymap.set("n", "<leader>ff", function()
  local ok, builtin = pcall(require, "telescope.builtin")
  if not ok then
    print("Telescope not loaded")
    return
  end
  builtin.find_files({
    cwd = vim.loop.cwd(),
    hidden = true,
    find_command = { "fd", "--type", "f", "--hidden", "--follow", "--exclude", ".git" },
  })
end, { desc = "Find Files (current folder + hidden)" })

-- <leader>fs → Live grep (search text recursively in current folder)
vim.keymap.set("n", "<leader>fs", function()
  local ok, builtin = pcall(require, "telescope.builtin")
  if not ok then
    print("Telescope not loaded")
    return
  end
  builtin.live_grep({
    cwd = vim.loop.cwd(),
    additional_args = function(_)
      return { "--hidden", "--no-ignore", "--glob", "!.git/*" }
    end,
  })
end, { desc = "Live Grep (search entire current folder)" })

