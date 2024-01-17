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

function Term:toggle()
  self.win:toggle()
end

return Term
