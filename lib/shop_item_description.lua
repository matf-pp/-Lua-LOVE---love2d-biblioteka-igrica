Shop_item_description = require("lib.shop_config").item_description_settings

function Shop_item_description:load()
    self.default_text = ""
    self.text = self.default_text
end

function Shop_item_description:update(dt)
    local selected_item = Shop.areas.items.selected_item
    if next(selected_item) ~= nil then
        self.text = selected_item.description
    else
        self.text = self.default_text
    end
end

function Shop_item_description:draw()
    love.graphics.setColor(unpack(self.color))
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

    love.graphics.setColor(1, 1, 0.5, 0.6)
    local text = self.text
    local font = love.graphics.newFont(20)
    love.graphics.setFont(font)
    love.graphics.print(text, self.x + 30, self.y + 20)
end

return Shop_item_description