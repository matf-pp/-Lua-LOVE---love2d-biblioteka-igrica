Shop = require("lib.shop_config").shop_settings

function Shop:load()
    self.areas = {
        header = require("lib.shop_header"),
        items = require("lib.shop_items"),
        currency = require("lib.shop_currency"),
        item_image = require("lib.shop_item_image"),
        price = require("lib.shop_item_price"),
        description = require("lib.shop_item_description")
    }

    for _, area in pairs(self.areas) do
        area:load()
    end
end

function Shop:update(dt)
    for _, area in pairs(self.areas) do
        area:update(dt)
    end
end

function Shop:draw()
    for _, area in pairs(self.areas) do
        area:draw()
    end
end

return Shop