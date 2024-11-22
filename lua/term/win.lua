local M = {}

local default_opts = {
  title = "Title",
  margin = 20,
  cmd = "echo hello",
}

function M.show(opts)
  opts = vim.tbl_deep_extend("force", default_opts, opts or {})

  -- Create an immutable scratch buffer that is wiped once hidden
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
  vim.api.nvim_buf_set_option(buf, "modifiable", false)

  -- Create a floating window with the scratch buffer
  local size = 1.0 - opts.margin / 100
  local win_area = {
    width = math.ceil(vim.o.columns * size),
    height = math.ceil(vim.o.lines * size),
  }

  local win = vim.api.nvim_open_win(buf, true, {
    style = "minimal",
    border = "rounded",
    relative = "editor",

    title = opts.title,
    width = win_area.width,
    height = win_area.height,

    row = math.ceil((vim.o.lines - win_area.height) / 2),
    col = math.ceil((vim.o.columns - win_area.width) / 2),
  })

  -- Change to the floating window
  vim.api.nvim_set_current_win(win)

  local cmd = vim.split(opts.cmd, " ")
  vim.fn.termopen(cmd, {
    -- cwd = vim.fn.getcwd(),
    -- env = vim.fn.environ(),
    on_exit = function(_, code)
      vim.print("Exited with code", code)

      if vim.api.nvim_win_is_valid(win) then
        vim.api.nvim_win_close(win, true)
      end
    end,
  })

  -- insert mode
  vim.cmd.startinsert()
end

return M
