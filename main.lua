require('lib.util').enableDebug()
require('lib.util').fixScaleBlur()
require('lib.util').setWindowSize(800, 600)

-- local enet = require('enet')
local loadP8 = require('lib.pico8')
love.graphics.setFont(loadP8('res/font.p8').createFont())

local widgetRes = loadP8('res/widgets.p8')

local function drawButton(x,y,scale,spr,text)
  local left = widgetRes.getOrMakeSpriteAt(spr+0)
  local mid = widgetRes.getOrMakeSpriteAt(spr+1)
  local right = widgetRes.getOrMakeSpriteAt(spr+2)

  left:draw(x,y,scale)
  mid:draw(x+(8*scale),y,scale)
  right:draw(x+(16*scale),y,scale)

  love.graphics.setColor(1,1,1)
  love.graphics.print(text, x+(2*scale),y+(2*scale),0,scale,scale)
end

function love.draw()
  love.graphics.clear()

  local mx, my = love.mouse.getPosition()
  drawButton(mx-10, my-50, 5, 0, "testing")
end
