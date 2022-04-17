Shop_item_image = require("lib.shop_config").item_image_settings

function Shop_item_image:load()
    -- TODO
    self.image = love.graphics.newImage("images/wall2.png")
end

function Shop_item_image:update(dt)
    -- TODO
    local selected_item = Shop.areas.items.selected_item
    if next(selected_item) ~= nil then
        self.image = selected_item.image
    end
end

function Shop_item_image:draw()
    love.graphics.setColor(unpack(self.color))
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

    love.graphics.setColor(1, 1, 1)
    local quad = love.graphics.newQuad(0, 0, 48, 48, 48, 48)
    love.graphics.draw(self.image, quad, self.x + self.width / 2, self.y + self.height / 2, 0, 1, 1, 24, 24)
end

return Shop_item_image