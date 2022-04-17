Shop_header = require("lib.shop_config").header_settings

function Shop_header:load()
    --
end

function Shop_header:update(dt)
    --
end

function Shop_header:draw()
    love.graphics.setColor(1, 1, 1)
    local bg_image = love.graphics.newImage("images/wall2.png")
    bg_image:setWrap("repeat", "repeat")
    local bg_quad = love.graphics.newQuad(0, 0, self.width, self.height, 48, self.height)

    love.graphics.draw(bg_image, bg_quad, self.x, self.y, 0, 1, 1)

    love.graphics.setColor(1, 1, 0.5, 0.6)
    love.graphics.setFont(Shop.shop_font)
    local text = "Shop"
    local font = love.graphics.getFont()
    local font_width = font:getWidth(text)
    local font_height = font:getHeight()
    love.graphics.print(text, self.x + self.width / 2, self.y + self.height / 2, 0, 1, 1, font_width / 2, font_height / 2)
end

return Shop_header