local Window = require("term.window")

local Term = {}

function Term:new(opts)
  local default_options = {
    title = "Terminal",
  }

  local obj = vim.tbl_deep_extend("force", default_options, opts or {})
  -- add window
  obj.win = Window:new({ title = obj.title })

  setmetatable(obj, self)
  self.__index = self
  return obj
end

function Term:start(cmd)
  self.win:show()

  vim.cmd("term " .. cmd)

  self.win:hide()
end

---@param code string
---@return string
function Term:termcode(code)
  return vim.api.nvim_replace_termcodes(code, true, false, true)
end

---@param input string
function Term:send(input)
  if not vim.api.nvim_buf_is_valid(self.win.buf) then
    return
  end

  if self.win:is_buf_hidden() then
    self.win:show()
  end

  vim.api.nvim_chan_send(vim.bo.channel, input .. self:termcode("<CR>"))
  self.win:hide()
end

return Term
