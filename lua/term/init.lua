local Term = require("term.term")

local M = {}

M.setup = function(opts)
  local term = Term:new()
  term:start(opts.shell or "bash")

  local opts = { noremap = true, silent = true }

  -- open term
  vim.keymap.set(
    { "n", "v", "i", "t" },
    "<C-Space>",
    function()
      term:toggle()
    end,
    opts
  )

  -- exit term mode
  vim.keymap.set(
    { "t" }, "<C-x>", "<C-\\><C-n>", opts
  )
end

return M
