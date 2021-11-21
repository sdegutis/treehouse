require('lib.util').setWindowSize(800, 800)

love.draw = function()
  love.graphics.clear()
  love.graphics.setColor(1,1,0)
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
