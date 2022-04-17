Shop_currency = require("lib.shop_config").currency_settings

function Shop_currency:load()
    -- TODO
    self.available = 10
end

function Shop_currency:update(dt)
    -- TODO
end

function Shop_currency:draw()
    love.graphics.setColor(unpack(self.color))
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

    love.graphics.setColor(1, 1, 1)
    local text = self.available
    local font = Shop.shop_font
    local text_width = font:getWidth(text)
    local text_height = font:getHeight()
    love.graphics.print(text, self.x + self.width * 0.3, self.y + self.height / 2, 0, 1, 1, text_width / 2, text_height / 2)

    love.graphics.setColor(1, 1, 1)
    local coin_image = love.graphics.newImage("images/coin_anim_f0.png")
    local quad = love.graphics.newQuad(0, 0, 48, 48, 48, 48)
    love.graphics.draw(coin_image, quad, self.x + self.width * 0.7, self.y + self.height / 2, 0, 1, 1, 24, 24)
end

return Shop_currency