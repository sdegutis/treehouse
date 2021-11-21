require('lib.util').enableDebug()
require('lib.util').fixScaleBlur()
require('lib.util').setWindowSize(800, 600)

-- local enet = require('enet')
local loadP8 = require('lib.pico8')

local widgetRes = loadP8('res/widgets.p8')
local font = loadP8('res/font.p8').createFont()
love.graphics.setFont(font)

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

  -- TestFont()
end

function TestFont()
  local spacer="\n\n"
  love.graphics.print("hello world!"..spacer..
                      "a=b+c^2 \\ 3 || false"..spacer..
                      "a:(c<3)"..spacer..
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
