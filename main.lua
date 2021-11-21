require('lib.util').enableDebug()
require('lib.util').fixScaleBlur()
require('lib.util').setWindowSize(800, 600)

-- local enet = require('enet')
local pico8 = require('lib.pico8')

local widgetRes = pico8.parseFile('res/widgets.p8')

function love.draw()
  love.graphics.clear()
  love.graphics.rectangle('line',10,10,100,100)
end

function love.update()
  -- local mx, my = love.mouse.getPosition()
end

function love.draw()
  love.graphics.clear()
  widgetRes.getOrMakeSpriteAt(1):draw(  20*3, 10, 4)
end
