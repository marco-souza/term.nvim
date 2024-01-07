local Window = require("term.window")

local Term = {}

function Term:new()
  local obj = {}

  setmetatable(obj, self)
  self.__index = self

  obj.win = Window:new({ title = "Terminal" })

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
