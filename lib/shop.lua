require("lib.map")
local level_data = require("levels.test_level_01")
local shop_data = require("lib.shop_config")

--[[
    Funkcija uzima string text i funkciju fn i pravi table sa podacima o dugmetu, gde je text ime dugmeta, a fn njegova funkcionalnost.
]]
local function new_button(text, fn)
    return {
        text = text,
        fn = fn,
        select = false,
        now = false,
        last = false
    }
end

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

    table.insert(
        self.buttons,
        new_button(
            "wall_button",
            function()
                print("uspesno pritisnuto wall dugme")
            end
        )
    )

    table.insert(
        self.buttons,
        new_button(
            "spike_button",
            function()
                print("uspesno pritisnuto spike dugme")
            end
        )
    )

    self.buttons.wall = new_button(
        "wall_button",
        function ()
            print("halo, dobar dan")
        end
    )

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
        draw = function (self)
            love.graphics.setColor(unpack(self.color))
            love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)

            love.graphics.setColor(1, 1, 1)

            local button_width = 48
            local button_height = 48

            local margin = 16
            -- local total_width = (button_width + margin) * #Shop.buttons
            local cursor_x = 0

            for _, button in pairs(Shop.buttons) do
                button.last = button.now

                local bx = self.x + margin + button_width / 2 + cursor_x
                local by = self.y + self.height / 2

                local mx, my = love.mouse.getPosition()

                local hot = mx > bx - button_width / 2 and mx < bx + button_width / 2 and
                            my > by - button_height / 2 and my < by + button_height / 2

                button.now = love.mouse.isDown(1)
                if button.now and not button.last and hot then
                    button.fn()
                    button.select = true
                end

                love.graphics.draw(level_data.images.wall_image, bx, by, 0, 1, 1, button_width / 2, button_height / 2)

                cursor_x = cursor_x + button_width + margin
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
    self.areas.selected = {
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
    if self.buttons.wall.select == true and love.mouse.isDown(2) then
        print("Juhu!")
        --[[
        local dx, dy =  love.mouse.getPosition()
        if Map:add_wall(dx,dy) == true then 
            print("Uspesno dodat zid na koordinatama ( "..dx.." , "..dy.." )")
            self.buttons[1].select = false
        else
            print("Neuspesno dodavanje zida na koordinatama (70, 30)")
        end
        ]]
    end
end

function Shop:draw()
    --love.graphics.setColor(0, 1, 0)
    --love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(self.shop_font)

    for _, area in pairs(self.areas) do
        area:draw()
    end
end