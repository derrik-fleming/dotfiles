-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local function create_group(name) return vim.api.nvim_create_augroup('local_' .. name, { clear = true }) end

vim.api.nvim_create_autocmd({ 'FileType' }, {
  group = create_group('language_ruler'),
  callback = function() vim.wo.colorcolumn = vim.bo.textwidth and '+1' or '' end,
})
