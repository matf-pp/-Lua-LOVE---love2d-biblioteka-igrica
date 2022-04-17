Shop_item_description = require("lib.shop_config").item_description_settings

function Shop_item_description:load()
    -- TODO
end

function Shop_item_description:update(dt)
    -- TOOD
end

function Shop_item_description:draw()
    love.graphics.setColor(unpack(self.color))
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

return Shop_item_description