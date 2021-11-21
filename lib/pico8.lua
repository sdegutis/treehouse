-- Version 1.0


---@param r number
---@param g number
---@param b number
local function makecolor(r,g,b,a)
  return { r/0xff, g/0xff, b/0xff, a or 1 }
end

local colorTable = {
  [0]=
  makecolor(0x00,0x00,0x00,0),
  makecolor(0x1D,0x2B,0x53),
  makecolor(0x7E,0x25,0x53),
  makecolor(0x00,0x87,0x51),
  makecolor(0xAB,0x52,0x36),
  makecolor(0x5F,0x57,0x4F),
  makecolor(0xC2,0xC3,0xC7),
  makecolor(0xFF,0xF1,0xE8),
  makecolor(0xFF,0x00,0x4D),
  makecolor(0xFF,0xA3,0x00),
  makecolor(0xFF,0xEC,0x27),
  makecolor(0x00,0xE4,0x36),
  makecolor(0x29,0xAD,0xFF),
  makecolor(0x83,0x76,0x9C),
  makecolor(0xFF,0x77,0xA8),
  makecolor(0xFF,0xCC,0xAA),
}

---@class Sprite
---@field image love.Image
---@field flag number
---@field flags boolean[]
local Sprite = {}

local function calcFlags(flag)
  local t = {}
  for i = 0, 7 do
    table.insert(t, i, bit.band(flag, 2^i) > 0)
  end
  return t
end

function Sprite.new(image, flag)
  local spr = {image=image, flag=flag, flags=calcFlags(flag)}
  setmetatable(spr, {__index = Sprite})
  return spr
end

---@param x number
---@param y number
---@param scale number default 1
function Sprite:draw(x, y, scale)
  love.graphics.draw(self.image, x, y, 0, scale, scale)
end

--- @param gfx string[] 0-128 lines of 128 char strings
--- @return number[][] spritesheet `colorIndexes[y=0-127][x=0-127]`
local function parseSpritesheet(gfx)
  local ss = {}

  for y = 0, 127 do
    local row = {}
    table.insert(ss, y, row)

    local chars = gfx[y+1] or string.rep('0', 128)

    for x = 0, 127 do
      local idx = x + 1
      local hex = chars:sub(idx,idx)
      local colorIndex = tonumber(hex, 16)
      table.insert(row, x, colorIndex)
    end
  end

  return ss
end

---@param spritesheet number[][]
---@param chars string
local function newFontFromSpritesheet(spritesheet, chars)
  local needsUpper = not chars:match("%u")

  local howManyExtra = 0
  if needsUpper then
    chars = chars:gsub("%l", function(s)
      howManyExtra = howManyExtra + 1
      return s .. s:upper()
    end)
  end

  -- Look at spr(0) to figure out how tall each glyph is
  
  local h = 8
  for y=0,7 do
    local allSame = true
    for x=1,7 do
      if spritesheet[y][x] ~= spritesheet[y][0] then
        allSame=false
        break
      end
    end
    if allSame then
      h=y
      break
    end
  end

  local imgdata = love.image.newImageData((8*16+howManyExtra)*8, h)

  local i = 0
  local function addGlyph(cx, cy)
    -- Loop through sprite
    for y=0,h-1 do
      local row = spritesheet[cy*8+y]
      for x=0,7 do
        local colorIndex = row[cx*8+x]
        imgdata:setPixel(i*8+x, y, colorTable[colorIndex])
      end
    end
    i=i+1
  end

  -- Loop through spritesheet
  for cy=0,7 do
    for cx=0,15 do
      addGlyph(cx, cy)

      if needsUpper and chars:sub(i,i):match("%l") then
        addGlyph(cx, cy)
      end
    end
  end

  return love.graphics.newImageFont(imgdata, chars)
end

---@param spritesheet number[][]
---@param sx number
---@param sy number
---@param w number
---@param h number
---@return love.Image
local function newImageFromSpritesheet(spritesheet, sx, sy, w, h)
  local data = love.image.newImageData(w,h)

  for py = 0, (h-1) do
    local rowIndex = sy * 8 + py
    local row = spritesheet[rowIndex]

    for px = 0, (w-1) do
      local idx = sx * 8 + px
      local colorIndex = row[idx]
      data:setPixel(px, py, colorTable[colorIndex])
    end
  end

  return love.graphics.newImage(data)
end

---@param lines any
local function parseGroups(lines)
  local groups = {}
  local groupname = '__intro__'
  for line in lines do
    if line:sub(1,2) == '__' then
      groupname = line
    else
      groups[groupname] = groups[groupname] or {}
      table.insert(groups[groupname], line)
    end
  end
  return groups
end

---@param t table
---@param v any
local function tableZeroBasedinsert(t, v)
  -- list           len   pos
  -- []             #0    0
  -- [0=a]          #0    1
  -- [0=a,1=b]      #1    2
  -- [0=a,1=b,2=c]  #2    3
  -- oh Lua...

  local pos = (t[0] == nil) and 0 or #t+1
  table.insert(t, pos, v)
end

---Returns a 2d array of sprite indexes.
---@param groups {__map__: string[], __gfx__: string[]}
---@return number[][]
local function parseMap(groups)
  -- 0-32 rows of 256 chars
  local map1 = groups.__map__ or {}

  -- 0-64 rows of 128 chars
  local map2 = {unpack(groups.__gfx__ or {}, 65)} or {}

  -- make them both 0-8192 chars
  map1 = table.concat(map1)
  map2 = table.concat(map2)

  -- pad end of each with 0s
  map1 = map1 .. string.rep('0', 8192-#map1)
  map2 = map2 .. string.rep('0', 8192-#map2)

  -- now we have a whole map we can loop through
  ---@type string
  local map = map1 .. map2

  local output = {}
  local i = 1
  for y = 1, 64 do
    local row = {}
    for x = 1, 128 do
      local hex = map:sub(i,i+1)

      -- reverse gfx-based map pairs
      if y > 32 then hex = hex:reverse() end

      local n = tonumber(hex, 16)
      tableZeroBasedinsert(row, n)

      i = i + 2
    end
    tableZeroBasedinsert(output, row)
  end

  return output
end

local function parseFlags(gff)
  gff = table.concat(gff)
  gff = gff .. string.rep('0', 512-#gff)

  local flags = {}

  for i = 0, 255 do
    local j = i*2 + 1
    local hex = gff:sub(j, j+1)
    local n = tonumber(hex, 16)
    table.insert(flags, i, n)
  end

  return flags
end

---@param filenameOrContents string
return function(filenameOrContents)
  local lines = filenameOrContents:match('^pico-8 cartridge')
                  and filenameOrContents:gmatch("(.-)\n")
                  or  love.filesystem.lines(filenameOrContents)
  local groups = parseGroups(lines)

  ---2d array of map sprite indexes: `map[y][x]` (0-indexed like PICO-8)
  local map = parseMap(groups)

  ---Array of flags: `flags[i]` (0-indexed like PICO-8)
  local flags = parseFlags(groups.__gff__ or {})

  local spritesheet = parseSpritesheet(groups.__gfx__ or {})

  ---Returns a new love.Image for this sprite
  ---@param i number (0-indexed like PICO-8)
  ---@param w number pixels wide (default 8)
  ---@param h number pixels tall (default 8)
  ---@return Sprite
  local function makeSpriteAt(i, w, h)
    local sx = i % 16
    local sy = math.floor(i / 16)
    local img = newImageFromSpritesheet(spritesheet, sx, sy, w or 8, h or 8)
    return Sprite.new(img, flags[i])
  end

  local cachedSprites = {}

  ---Returns a cached (or new) love.Image for this sprite
  ---@param i number (0-indexed like PICO-8)
  ---@param w number pixels wide (default 8)
  ---@param h number pixels tall (default 8)
  ---@return Sprite
  local function getOrMakeSpriteAt(i, w, h)
    if not cachedSprites[i] then
      cachedSprites[i] = makeSpriteAt(i, w, h)
    end
    return cachedSprites[i]
  end

  ---Returns new font
  ---@param chars string[] | nil omit this to use chars in Lua code
  ---@return love.Font
  local function createFont(chars)
    return newFontFromSpritesheet(spritesheet, chars or table.concat(groups.__lua__))
  end

  return {
    makeSpriteAt = makeSpriteAt,
    getOrMakeSpriteAt = getOrMakeSpriteAt,
    map = map,
    flags = flags,
    createFont = createFont,
  }
end
