Shop_items = require("lib.shop_config").items_settings
local level_data = require("lib.shop_config").level_data

function Shop_items:load()
    self.buttons = {}
    self.selected_item = {}

    self.buttons.wall = {
        selected = false,
        now = false,
        last = false,
        image = level_data.images.wall_image,
        cost = 3
    }

    function self.buttons.wall:on_press()
        for _, button in pairs(Shop_items.buttons) do
            button.selected = false
        end
        self.selected = true
        Shop_items.selected_item = self
    end

    self.buttons.spikes = {
        selected = false,
        now = false,
        last = false,
        image = level_data.images.spikes_image_3,
        cost = 1
    }

    function self.buttons.spikes:on_press()
        for _, button in pairs(Shop_items.buttons) do
            button.selected = false
        end
        self.selected = true
        Shop_items.selected_item = self
    end

    for _, button in pairs(self.buttons) do
        function button:pay()
            local new_balance = Shop.areas.currency.available - self.cost
            if new_balance < 0 then
                print("no can do, sir")
                return false
            else
                Shop.areas.currency.available = new_balance
                return true
            end
        end
    end
end

function Shop_items:update(dt)
    if self.buttons.wall.selected == true and love.mouse.isDown(2) then
        local dx, dy =  love.mouse.getPosition()
        if self.buttons.wall:pay() == true then
            Map:add_wall(dx, dy)
        end
        self.buttons.wall.selected = false
    end

    if self.buttons.spikes.selected == true and love.mouse.isDown(2) then
        local dx, dy =  love.mouse.getPosition()
        if self.buttons.spikes:pay() == true then
            Map:add_spikes(dx, dy)
        end
        self.buttons.spikes.selected = false
    end
end

function Shop_items:draw()
    love.graphics.setColor(unpack(self.color))
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

    love.graphics.setColor(1, 1, 1)

    local margin = 16
    local cursor_x = 0

    for _, button in pairs(self.buttons) do
        button.last = button.now

        local bx = self.x + margin + self.button_width / 2 + cursor_x
        local by = self.y + self.height / 2

        local mx, my = love.mouse.getPosition()

        local hot = mx > bx - self.button_width / 2 and mx < bx + self.button_width / 2 and
                    my > by - self.button_height / 2 and my < by + self.button_height / 2

        button.now = love.mouse.isDown(1)
        if button.now and not button.last and hot then
            button:on_press()
        end

        local quad = love.graphics.newQuad(0, 0, 48, 48, self.button_width, self.button_height)
        love.graphics.draw(button.image, quad, bx, by, 0, 1, 1, self.button_width / 2, self.button_height / 2)

        cursor_x = cursor_x + self.button_width + margin
    end
end

return Shop_items