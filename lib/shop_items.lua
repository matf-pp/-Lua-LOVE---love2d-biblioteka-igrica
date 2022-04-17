Shop_items = require("lib.shop_config").items_settings
local level_data = require("lib.shop_config").level_data

function Shop_items:load()
    self.buttons = {
        wall = {},
        spikes = {}
    }
    self.selected_item = {}

    self.buttons.wall = {
        selected = false,
        now = false,
        last = false,
        image = level_data.images.wall_image,
        cost = 3,
        description = "WALL\n\nPlaces a wall on a clear field. Walls are\nimpassable."
    }

    self.buttons.spikes = {
        selected = false,
        now = false,
        last = false,
        image = level_data.images.spikes_image_3,
        cost = 1,
        description = "SPIKES\n\nPlaces spikes on a clear field. Spikes hurt\nmonsters walking over them."
    }

    local margin = 16
    local cursor_x = 0
    for _, button in pairs(self.buttons) do
        button.width = 48
        button.height = 48
        button.x = self.x + button.width / 2 + margin + cursor_x
        button.y = self.y + self.height / 2

        cursor_x = cursor_x + button.width + margin
    
        function button:on_press()
            for _, other_button in pairs(Shop_items.buttons) do
                other_button.selected = false
            end
            self.selected = true
            Shop_items.selected_item = self
        end

        function button:can_pay()
            local new_balance = Shop.areas.currency.available - self.cost
            if new_balance < 0 then
                return false
            end
            return true
        end

        function button:pay()
            Shop.areas.currency.available = Shop.areas.currency.available - self.cost
        end

        function button:effect(x, y)
            if self == Shop_items.buttons.wall then
                return Map:add_wall(x, y)
            elseif self == Shop_items.buttons.spikes then
                return Map:add_spikes(x, y)
            end
        end

        function button:update(dt)
            if self.selected == true and love.mouse.isDown(2) then
                local dx, dy =  love.mouse.getPosition()
                if self:can_pay() == true then
                    if self:effect(dx, dy) == true then
                        self:pay()
                    end
                end
                self.selected = false
            end

            self.last = self.now

            local mx, my = love.mouse.getPosition()

            local hot = mx > self.x - self.width / 2 and mx < self.x + self.width / 2 and
                        my > self.y - self.height / 2 and my < self.y + self.height / 2

            self.now = love.mouse.isDown(1)
            if self.now and not self.last and hot then
                button:on_press()
            end
        end

        function button:draw()
            love.graphics.setColor(1, 1, 1)
            local quad = love.graphics.newQuad(0, 0, 48, 48, self.width, self.height)
            love.graphics.draw(self.image, quad, self.x, self.y, 0, 1, 1, self.width / 2, self.height / 2)
        end
    end
end

function Shop_items:update(dt)
    for _, button in pairs(self.buttons) do
        button:update(dt)
    end
end

function Shop_items:draw()
    love.graphics.setColor(unpack(self.color))
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

    for _, button in pairs(self.buttons) do
        button:draw()
    end
end

return Shop_items