local Window = {}

function Window:new(opts)
  local obj = {}

  setmetatable(obj, self)
  self.__index = self

  opts = opts or {}

  obj.win = nil
  obj.margin = 20
  obj.title = opts.title or "New window"
  obj.buf = vim.api.nvim_create_buf(false, true)

  return obj
end

function Window:toggle()
  if not self.win then
    self:show()
  else
    self:hide()
  end
end

function Window:hide()
  if not self.win then
    return
  end

  vim.api.nvim_win_hide(self.win)
  vim.cmd("stopinsert")
  self.win = nil
end

function Window:show()
  if not self:is_buf_hidden() then
    return
  end

  -- create window
  local configs = self:_center_win_config({ title = self.title })
  self.win = vim.api.nvim_open_win(self.buf, true, configs)

  -- setup window
  vim.wo.relativenumber = false
  vim.o.number = false
  vim.bo.buflisted = false
  vim.wo.foldcolumn = "0"

  vim.cmd("startinsert")
end

function Window:is_buf_hidden()
  local buf_info = vim.fn.getbufinfo(self.buf)[1]
  return not buf_info or buf_info.hidden == 1
end

function Window:_center_win_config(opts)
  -- Calculate a minimal width with a bit buffer
  local width = opts.width
  if not width or width + self.margin > vim.api.nvim_win_get_width(0) then
    width = vim.api.nvim_win_get_width(0) - self.margin
    if width < 0 then
      width = 1
    end
  end

  -- Calculate a minimal height with a bit buffer
  local height = opts.height
  if not height or height + self.margin > vim.api.nvim_win_get_height(0) then
    height = vim.api.nvim_win_get_height(0) - self.margin
    if height < 0 then
      height = 1
    end
  end

  return {
    focusable = true,
    style = "minimal",
    border = "rounded",
    width = width,
    height = height,
    title = self.title,
    -- center
    relative = "win",
    row = vim.api.nvim_win_get_height(0) / 2 - height / 2,
    col = vim.api.nvim_win_get_width(0) / 2 - width / 2,
  }
end

return Window
