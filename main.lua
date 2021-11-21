require('lib.util').enableDebug()
require('lib.util').fixScaleBlur()
require('lib.util').setWindowSize(800, 600)

-- local enet = require('enet')
local loadP8 = require('lib.pico8')

love.graphics.setFont(loadP8('res/font.p8').createFont())

local Button = {}

function Button.new(p8, x, y, scale, spr, text)
  return setmetatable({
    x=x,y=y,
    scale=scale,
    spr=spr,
    text=text,
    spritesUp = {
      left  = p8.getOrMakeSpriteAt(spr+0),
      mid   = p8.getOrMakeSpriteAt(spr+1),
      right = p8.getOrMakeSpriteAt(spr+2),
    },
    spritesDown = {
      left  = p8.getOrMakeSpriteAt(spr+0+16),
      mid   = p8.getOrMakeSpriteAt(spr+1+16),
      right = p8.getOrMakeSpriteAt(spr+2+16),
    },
  }, {__index=Button})
end

function Button:draw()
  local sprites = self.spritesUp
  local x = self.x
  local y = self.y
  local scale = self.scale
  local text = self.text

  local numSprs = #text/2 + 1 -- 2 chars per sprite, - 1 sprite total for left/right padding
  local eachSprPixels = 8*scale

  love.graphics.setColor(1,1,1)

  for i=0,numSprs-1 do
    sprites.mid:draw(x+eachSprPixels*i,y,scale)
  end

  sprites.left:draw(x,y,scale)
  sprites.right:draw(x+(eachSprPixels*(numSprs-1.5)),y,scale)

  love.graphics.setColor(0,0,0)
  love.graphics.print(text, x+(2*scale),y+(2*scale),0,scale,scale)
end

function Button:update()
  local mx, my = love.mouse.getPosition()

  
end

local widgetRes = loadP8('res/widgets.p8')

local b1 = Button.new(widgetRes, 10,10, 5, 0, "Testing this!")
local b2 = Button.new(widgetRes, 130,150, 3, 0, "yep")

function love.draw()
  love.graphics.clear(0,0.15,0)
  b1:draw()
  b2:draw()
end

function love.update()
  b1:update()
  b2:update()
end
