-- Make sure Neovim can find your config inside dotfiles
vim.opt.runtimepath:prepend(vim.fn.expand("~/dotfiles/.config/nvim"))

-- Make sure Lazy.nvim’s path is in runtimepath
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Try loading Lazy.nvim explicitly
pcall(require, "lazy")

-- Load your actual Neovim config
require("zenkai.core")
require("zenkai.lazy")

