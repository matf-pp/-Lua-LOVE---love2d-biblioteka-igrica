Shop_currency = require("lib.shop_config").currency_settings

function Shop_currency:load()
    -- TODO
end

function Shop_currency:update(dt)
    -- TODO
end

function Shop_currency:draw()
    love.graphics.setColor(unpack(self.color))
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end

return Shop_currency