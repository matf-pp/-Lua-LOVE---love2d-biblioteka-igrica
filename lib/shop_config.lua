local height_ratio = 3 / 5
local width_ratio = 3 / 5

local x = 0
local y = love.graphics.getHeight() * height_ratio
local width = love.graphics.getWidth() * width_ratio
local height = love.graphics.getHeight() * (1 - height_ratio)
local shop_font = love.graphics.newFont(32)

return {
    x = x,
    y = y,
    width = width,
    height = height,
    shop_font = shop_font
}