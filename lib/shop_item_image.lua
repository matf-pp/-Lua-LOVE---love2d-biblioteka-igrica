Shop_item_image = require("lib.shop_config").item_image_settings

function Shop_item_image:load()
    -- TODO
end

function Shop_item_image:update(dt)
    -- TODO
end

function Shop_item_image:draw()
    love.graphics.setColor(unpack(self.color))
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

return Shop_item_image