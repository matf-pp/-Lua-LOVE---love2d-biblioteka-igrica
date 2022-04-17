Shop_item_price = require("lib.shop_config").item_price_settings

function Shop_item_price:load()
    -- TODO
    self.cost = "?"
end

function Shop_item_price:update(dt)
    -- TODO
    local selected_item = Shop.areas.items.selected_item
    if next(selected_item) ~= nil then
        self.cost = selected_item.cost
    end
end

function Shop_item_price:draw()
    love.graphics.setColor(unpack(self.color))
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

    love.graphics.setColor(1, 1, 1)
    local text = self.cost
    local font = Shop.shop_font
    local text_width = font:getWidth(text)
    local text_height = font:getHeight()
    love.graphics.print(text, self.x + self.width * 0.3, self.y + self.height * 0.45, 0, 1, 1, text_width / 2, text_height / 2)

    love.graphics.setColor(1, 1, 1)
    local coin_image = love.graphics.newImage("images/coin_anim_f0.png")
    local quad = love.graphics.newQuad(0, 0, 48, 48, 48, 48)
    love.graphics.draw(coin_image, quad, self.x + self.width * 0.7, self.y + self.height * 0.45, 0, 1, 1, 24, 24)
end

return Shop_item_price