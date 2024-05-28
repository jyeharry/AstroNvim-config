-- This file simply bootstraps the installation of Lazy.nvim and then calls other files for execution
-- This file doesn't necessarily need to be touched, BE CAUTIOUS editing this file and proceed at your own risk.
local lazypath = vim.env.LAZY or vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.env.LAZY or (vim.uv or vim.loop).fs_stat(lazypath)) then
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- validate that lazy is available
if not pcall(require, "lazy") then
  -- stylua: ignore
  vim.api.nvim_echo({ { ("Unable to load lazy from: %s\n"):format(lazypath), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } }, true, {})
  vim.fn.getchar()
  vim.cmd.quit()
end

require "lazy_setup"
require "polish"

local function set_keymap(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local function set_keymaps()
  set_keymap('n', '<C-l>', ':bnext<CR>', { desc = "Next buffer" })
  set_keymap('n', '<C-h>', ':bprevious<CR>', { desc = "Previous buffer" })
  set_keymap('n', "<C-k>", "<C-u>", { desc = "Scroll up half a page" })
  set_keymap('n', "<C-j>", "<C-d>", { desc = "Scroll down half a page" })
end

set_keymaps()

-- if needed, create an autocmd that runs on BufEnter
vim.api.nvim_create_autocmd('User', {
  pattern = 'LazyVimDone',
  callback = function()
    set_keymaps()
  end,
})
