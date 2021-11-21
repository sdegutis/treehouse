require('lib.util').enableDebug()
require('lib.util').fixScaleBlur()
require('lib.util').setWindowSize(800, 600)

-- local enet = require('enet')
local loadP8 = require('lib.pico8')

local widgetRes = loadP8('res/widgets.p8')
local font = loadP8('res/font.p8').createFont()

function love.load()
  love.graphics.setFont(font)
end

function love.draw()
end

function love.update()
  -- local mx, my = love.mouse.getPosition()
end

function love.draw()
  love.graphics.clear()
  -- love.graphics.setColor(0,0.5,0.5)
  -- love.graphics.rectangle('fill',10,10,200,35)
  -- love.graphics.setColor(0,1,1)
  -- love.graphics.rectangle('line',10,10,200,35)
  -- widgetRes.getOrMakeSpriteAt(1):draw(  20*3, 10, 4)

  love.graphics.setColor(1,1,0)
  love.graphics.print("hello world!\n\n"..
                      "a+b=c\n\n"..
                      "[char]\n\n"..
                      "(what?)\n\n"..
                      "You know; it's great!\n\n"..
                      "Or is it?\n\n"..
                      "Yes, it is.\n\n"..
                      "12 + 34 / 56 - 78 * 90 = 30%\n\n"..
                      "", 14,14,0,4,4)
end
