require("lib.map")
local level_data = require("lib.level_data")
local shop_data = require("lib.shop_config")

Shop = {}

function Shop:load()
    -- koordinate gornjeg levog ugla shop-a
    self.x, self.y = shop_data.x, shop_data.y
    -- sirina i visina shop-a
    self.width, self.height = shop_data.width, shop_data.height
    -- font koji se koristi u shop-u
    self.shop_font = shop_data.shop_font
    -- dugmici u shop-u
    self.buttons = {}

    self.buttons.wall = {
        selected = false,
        now = false,
        last = false,
        image = level_data.images.wall_image
    }

    function self.buttons.wall:on_press()
        for _, button in pairs(Shop.buttons) do
            button.selected = false
        end
        self.selected = true
    end

    self.buttons.spikes = {
        selected = false,
        now = false,
        last = false,
        image = level_data.images.spikes_image_3
    }

    function self.buttons.spikes:on_press()
        for _, button in pairs(Shop.buttons) do
            button.selected = false
        end
        self.selected = true
    end

    self.selected_button = self.buttons.wall

    self.areas = {}

    self.areas.header = {
        x = self.x,
        y = self.y,
        width = self.width,
        height = self.height * 1 / 6,
        color = {1, 1, 1},
        draw = function (self)
            love.graphics.setColor(unpack(self.color))
            --love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
            
            local bg_image = love.graphics.newImage("images/wall2.png")
            bg_image:setWrap("repeat", "repeat")
            local bg_quad = love.graphics.newQuad(0, 0, self.width, self.height, 48, self.height)

            love.graphics.draw(bg_image, bg_quad, self.x, self.y, 0, 1, 1)

            love.graphics.setColor(1, 1, 0.5, 0.6)
            local text = "Shop"
            local font = love.graphics.getFont()
            local font_width = font:getWidth(text)
            local font_height = font:getHeight()
            love.graphics.print(text, self.x + self.width / 2, self.y + self.height / 2, 0, 1, 1, font_width / 2, font_height / 2)
        end
    }
    self.areas.items = {
        x = self.x,
        y = self.y + self.height * 1 / 6,
        width = self.width * 4 / 5,
        height = self.height * 1 / 3,
        color = {71/255, 74/255, 252/255},
        button_width = 48,
        button_height = 48,
        draw = function (self)
            love.graphics.setColor(unpack(self.color))
            love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

            love.graphics.setColor(1, 1, 1)

            local margin = 16
            -- local total_width = (button_width + margin) * #Shop.buttons
            local cursor_x = 0

            for _, button in pairs(Shop.buttons) do
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
    }
    self.areas.currency = {
        x = self.x + self.width * 4 / 5,
        y = self.y + self.height * 1 / 6,
        width = self.width * 1 / 5,
        height = self.height * 1 / 3,
        color = {57/255, 60/255, 227/255},
        draw = function (self)
            love.graphics.setColor(unpack(self.color))
            love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
        end
    }
    self.areas.selected_item = {
        x = self.x,
        y = self.y + self.height * 1 / 2,
        width = self.width * 1 / 5,
        height = self.height * 1 / 3,
        color = {57/255, 60/255, 227/255},
        draw = function (self)
            love.graphics.setColor(unpack(self.color))
            love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
        end
    }
    self.areas.price = {
        x = self.x,
        y = self.y + self.height * 5 / 6,
        width = self.width * 1 / 5,
        height = self.height * 1 / 6,
        color = {44/255, 50/255, 201/255},
        draw = function (self)
            love.graphics.setColor(unpack(self.color))
            love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
        end
    }
    self.areas.description = {
        x = self.x + self.width * 1 / 5,
        y = self.y + self.height * 1 / 2,
        width = self.width * 4 / 5,
        height = self.height * 1 / 2,
        color = {50/255, 55/255, 227/255},
        draw = function (self)
            love.graphics.setColor(unpack(self.color))
            love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
        end
    }
end

function Shop:update(dt)
    -- TODO
    if self.buttons.wall.selected == true and love.mouse.isDown(2) then
        local dx, dy =  love.mouse.getPosition()
        Map:add_wall(dx, dy)
        self.buttons.wall.selected = false
    end

    if self.buttons.spikes.selected == true and love.mouse.isDown(2) then
        local dx, dy =  love.mouse.getPosition()
        Map:add_spikes(dx, dy)
        self.buttons.spikes.selected = false
    end
end

function Shop:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(self.shop_font)

    for _, area in pairs(self.areas) do
        area:draw()
    end
end

return Shop