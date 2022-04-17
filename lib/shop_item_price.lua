Shop_item_price = require("lib.shop_config").item_price_settings

function Shop_item_price:load()
    -- TODO
end

function Shop_item_price:update(dt)
    -- TODO
end

function Shop_item_price:draw()
    love.graphics.setColor(unpack(self.color))
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

return Shop_item_price