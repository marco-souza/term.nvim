local Term = require("term.term")

local M = {}

local default_options = {
  shell = "bash",
  mappings = {
    toggle_terminal = "<C-Space>",
    quit_term_mode = "<C-x>"
  },
}

-- TODO: handle multiple terminals
M.setup = function(opts)
  local term = Term:new()
  local options = vim.tbl_deep_extend(
    "force",
    default_options,
    opts or {}
  )

  -- start terminal
  term:start(options.shell or "bash")

  -- toggle terminal
  vim.keymap.set(
    { "n", "v", "i", "t" },
    options.mappings.toggle_terminal,
    function()
      term:toggle()
    end,
    { noremap = true, silent = true }
  )

  -- exit term mode
  vim.keymap.set(
    { "t" },
    options.mappings.quit_term_mode,
    "<C-\\><C-n>",
    { noremap = true, silent = true }
  )
end

return M
