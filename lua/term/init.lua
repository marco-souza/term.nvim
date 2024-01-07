local Term = require("term.term")

local M = {}

local function set_keymaps(win)
end

M.setup = function(opts)
  local term = Term:new()
  term:start(opts.shell or "bash")

  local opts = { noremap = true, silent = true }
  vim.keymap.set(
    { "n", "v", "i", "t" },
    "<C-Space>",
    term:toggle,
    opts
  )
end

return M
