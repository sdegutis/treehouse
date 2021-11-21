return {

  enableDebug = function()
    if pcall(require, "lldebugger") then require("lldebugger").start() end
    if pcall(require, "mobdebug") then require("mobdebug").start() end
  end,

  setWindowSize = function(w,h)
    local winw, winh = love.window.getMode()
    if winw ~= 800 or winh ~= 600 then
      love.window.setMode(800, 600)
    end
  end,

  fixScaleBlur = function()
    love.graphics.setDefaultFilter("nearest", "nearest")
  end,

}
