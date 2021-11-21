require('lib.util').enableDebug()
require('lib.util').fixScaleBlur()
require('lib.util').setWindowSize(800, 800)

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

  local spacer="\n\n"

  love.graphics.setColor(1,1,0)
  love.graphics.print("hello world!"..spacer..
                      "a+b=c^2 \\ 3 || false"..spacer..
                      "a = (c<3)"..spacer..
                      "[char]"..spacer..
                      "@char"..spacer..
                      "$50 for gold"..spacer..
                      "#char"..spacer..
                      "(and what?)"..spacer..
                      "Zebras!!!"..spacer..
                      "\"Sphinx of black quartz, judge my vow\""..spacer..
                      " -- that's used by Adobe InDesign (lol wut)"..spacer..
                      "\"Pack my box with five dozen liquor jars\""..spacer..
                      " -- that one's supposedly used by NASA"..spacer..
                      "<one more_thing_left>"..spacer..
                      "You know; it's great!"..spacer..
                      "Or isn't it?"..spacer..
                      "Yes, it is."..spacer..
                      "Oh, \"you know\" isn't enough!"..spacer..
                      "12 + 34 / 56 - 78 * 90 = 30%"..spacer..
                      "", 14,14,0,4,4)
end
