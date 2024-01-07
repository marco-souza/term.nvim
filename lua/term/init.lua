local Term = require("term.term")

local M = {}

local function set_keymaps()
  local opts = { noremap = true, silent = true }
  local term_opts = { silent = true }

  vim.api.nvim_set_keymap("n", "C-<leader>", opts)
  vim.api.nvim_set_keymap("v", "C-<leader>", opts)
  vim.api.nvim_set_keymap("i", "C-<leader>", opts)
  vim.api.nvim_set_keymap("t", "C-<leader>", term_opts)
end

M.setup = function(opts)
  local term = Term:new()
  term:start(opts.shell or "bash")

  set_keymaps()
end

return M
