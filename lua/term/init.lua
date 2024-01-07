local Term = require("term.term")

local M = {}

local function set_keymaps(win)
  local opts = { noremap = true, silent = true }

  vim.keymap.set(
    { "n", "v", "i", "t" },
    "C-<leader>",
    handler,
    opts
  )
end

M.setup = function(opts)
  local term = Term:new()

  term:start(opts.shell or "bash")

  set_keymaps(term.win)
end

return M
