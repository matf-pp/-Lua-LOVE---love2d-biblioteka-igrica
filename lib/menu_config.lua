local x = love.graphics.getWidth() * 3 / 5
local y = love.graphics.getHeight() * 3 / 5
local width = love.graphics.getWidth() * 2 / 5
local height = love.graphics.getHeight() * 2 / 5

local bg_image = love.graphics.newImage("images/path.png")
bg_image:setWrap("repeat", "repeat")
local bg_quad = love.graphics.newQuad(0, 0, width, height, bg_image:getWidth(), bg_image:getHeight())

return {
    x = x,
    y = y,
    width = width,
    height = height,
    bg_image = bg_image,
    bg_quad = bg_quad
}